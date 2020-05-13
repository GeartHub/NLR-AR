//
//  ViewController.swift
//  NLR AR
//
//  Created by Geart Otten on 02/04/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".serialSceneKitQueue")
    
    var sceneView = ARSCNView()
    
    var messageLabel = UILabel()
    var drawButton = UIButton()
    var resetButton = UIButton()
    var saveButton = UIButton()
    
    var f16Object: SCNNode!
    
    var test: ARSCNView!
    
    var randobool: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Autoresizing is the automatic contraints of Apple, we dont want that.
        self.sceneView.translatesAutoresizingMaskIntoConstraints = false
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.drawButton.translatesAutoresizingMaskIntoConstraints = false
        self.resetButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup of draw button
        self.drawButton.setTitleColor(.systemBlue, for: .normal)
        self.drawButton.setTitle("Draw", for: .normal)
        
        // Setup of resetButton
        self.resetButton.setTitleColor(.systemBlue, for: .normal)
        self.resetButton.setTitle("Restart", for: .normal)
        self.resetButton.addTarget(self, action: #selector(restartSession), for: .touchUpInside)
        
        // Setup of draw button
        self.saveButton.setTitleColor(.systemBlue, for: .normal)
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.addTarget(self, action: #selector(saveSession), for: .touchUpInside)
        
        
        // Setup of sceneView
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.automaticallyUpdatesLighting = true
        
        // Adding the items to the View
        view.addSubview(sceneView)
        view.addSubview(messageLabel)
        view.addSubview(drawButton)
        view.addSubview(resetButton)
        view.addSubview(saveButton)
        
        restartSession()
        setupConstraints()
        registerGestureRecognizers()
        guard let f16Scene = SCNScene(named: "F-16D.scn") else { return }
        guard let f16Object = f16Scene.rootNode.childNode(withName: "Plane", recursively: true) else { return }
        self.f16Object = f16Object
        self.f16Object.scale = SCNVector3(0.1, 0.1, 0.1)
        self.f16Object.name = "F-16"
    }
    
    @objc
    func saveSession() {
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: sceneView.scene, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "SavedScene")
            debugPrint("Saving plane")
        }
        
    }
    
    
    func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func loadSession() {
        let defaults = UserDefaults.standard
        if let savedSession = defaults.object(forKey: "SavedScene") as? Data {
            if let decodedSession = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedSession) as? SCNScene {
                sceneView.scene = decodedSession
            }
        }
    }
    
    /// Setup of the contraints fot this viewcontroller. This is the placement of the items.
    private func setupConstraints() {
        // sceneViewConstraints
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sceneView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // messageLabelConstraints
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        // drawButtonContraints
        NSLayoutConstraint.activate([
            drawButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            drawButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //resetButtonConstraints
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resetButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20)
        ])
        
        //resetButtonConstraints
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            saveButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    func addItem(hitTestResult: ARHitTestResult) {
        let node = SCNNode(geometry: SCNSphere(radius: 1))
        let transform = hitTestResult.worldTransform
        let thirdColumn = transform.columns.3
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.name = "sphere"
        node.position = SCNVector3(thirdColumn.x, thirdColumn.y, thirdColumn.z)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    @objc
    func tapped(sender: UITapGestureRecognizer) {
        let tappedLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(tappedLocation, types: .featurePoint)
        if !hitTest.isEmpty {
            let result = hitTest.first!
            loadSession()
            
        } else {
            print("nope")
        }
    }
    
    /// This function restarts the AR session so everything is ready to go again.
    @objc
    private func restartSession() {
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        guard let referenceObjects = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources", bundle: nil) else { return }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        configuration.detectionObjects = referenceObjects
        self.sceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
            if node.name == "sphere" {
                node.removeFromParentNode()
            }
        })
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        self.sceneView.delegate = self
        self.sceneView.session.delegate = self
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        var nameScannedObject = ""
        if let objectAchnor = anchor as? ARObjectAnchor {
            guard let objectName = objectAchnor.referenceObject.name else { return }
            nameScannedObject = objectName
        }
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let referenceImage = imageAnchor.referenceImage
            guard let imageName = referenceImage.name else { return }
            nameScannedObject = imageName
            updateQueue.async {
                DispatchQueue.main.async {
                    self.messageLabel.text = ("Detected image “\(nameScannedObject)”")
                    
                    print("Geart is cool")
                }
                
                print(anchor.transform.columns)
                
                        
                if self.randobool == true {
                    node.addChildNode(self.f16Object)
                } else {
                    self.loadSession()
                }
                print(self.f16Object.position)
                // Create a plane to visualize the initial position of the detected image.
                let plane = SCNPlane(width: referenceImage.physicalSize.width,
                                     height: referenceImage.physicalSize.height)
                let planeNode = SCNNode(geometry: plane)
                planeNode.opacity = 0.01

                /*
                 `SCNPlane` is vertically oriented in its local coordinate space, but
                 `ARImageAnchor` assumes the image is horizontal in its local space, so
                 rotate the plane to match.
                 */
                planeNode.eulerAngles.x = -.pi / 2

                /*
                 Image anchors are not tracked after initial detection, so create an
                 animation that limits the duration for which the plane visualization appears.
                 */
    //            planeNode.runAction(self.imageHighlightAction)

                // Add the plane visualization to the scene.
                node.addChildNode(planeNode)

            }
        }
    }
    private func rotation(time: TimeInterval) -> SCNAction {
        let action = SCNAction.rotateBy(x: CGFloat(360.degreesToRadians), y: 0, z: 0, duration: time)
        let foreverAction = SCNAction.repeatForever(action)
        return foreverAction
    }
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
        let currentPositionOfCamera = orientation + location
        DispatchQueue.main.async {
            if self.drawButton.isHighlighted {
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.008))
                scene.rootNode.addChildNode(sphereNode)
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                sphereNode.position = currentPositionOfCamera
                sphereNode.name = "sphere"
            } else {
                let pointer = SCNNode(geometry: SCNSphere(radius: 0.005))
                pointer.name = "pointer"
                pointer.position = currentPositionOfCamera
                scene.rootNode.enumerateChildNodes({ (node, _) in
                    if node.name == "pointer" {
                        node.removeFromParentNode()
                    }
                })
                self.sceneView.scene.rootNode.addChildNode(pointer)
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red

            }
        }
    }

}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    
}
