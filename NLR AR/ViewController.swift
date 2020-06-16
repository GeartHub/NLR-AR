//
//  ViewController.swift
//  NLR AR
//
//  Created by Geart Otten on 02/04/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit
import ARKit
import CoreData

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".serialSceneKitQueue")
    
    var sceneView = ARSCNView()
    
    var messageLabel = UILabel()
    var resetButton = UIButton()
    var saveButton = UIButton()
    var messageView = UIView()
    var testButton = UIButton()
    
    var coordinates: [Float] = []
    
    var f16Object: SCNNode!
    
    var hasAddedPlane: Bool = false
    
    var isAdding: Bool = false
    var aircraft: Aircraft?
    
    let coreDataContext = CoreDataStack.instance.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Autoresizing is the automatic contraints of Apple, we dont want that.
        self.sceneView.translatesAutoresizingMaskIntoConstraints = false
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.messageView.translatesAutoresizingMaskIntoConstraints = false
        self.resetButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.testButton.translatesAutoresizingMaskIntoConstraints = false
      
        // Setup of resetButton
        self.resetButton.setTitleColor(.systemBlue, for: .normal)
        self.resetButton.setTitle("Restart", for: .normal)
        self.resetButton.addTarget(self, action: #selector(restartSession), for: .touchUpInside)
        
        // Setup of draw button
        self.saveButton.setTitleColor(.systemBlue, for: .normal)
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.addTarget(self, action: #selector(saveSession), for: .touchUpInside)
        
        self.testButton.setTitleColor(.systemBlue, for: .normal)
        self.testButton.setTitle("Test", for: .normal)
        self.testButton.addTarget(self, action: #selector(testSession), for: .touchUpInside)
        
        // Setup of sceneView
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.automaticallyUpdatesLighting = true
        
        // Setting up the navigation
        navigationController?.navigationBar.prefersLargeTitles = false
        
        
        // Styling the messageView
        self.messageView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.5)
        self.messageView.layer.masksToBounds = true
        self.messageView.layer.cornerRadius = 10.0
        
        // Styling the messageLabel
        self.messageLabel.textAlignment = .center
        self.messageLabel.lineBreakMode = .byWordWrapping
        self.messageLabel.numberOfLines = 0
        
        // Adding the items to the View
        view.addSubview(sceneView)
        view.addSubview(resetButton)
        view.addSubview(saveButton)
        view.addSubview(messageView)
        view.addSubview(testButton)
        messageView.addSubview(messageLabel)
        
        restartSession()
        setupConstraints()
        registerGestureRecognizers()
        guard let f16Scene = SCNScene(named: "fullsize.scn") else { return }
        guard let f16Object = f16Scene.rootNode.childNode(withName: "F-16D", recursively: true) else { return }
        self.f16Object = f16Object
        self.f16Object.scale = SCNVector3(0.1, 0.1, 0.1)
        self.f16Object.name = "F-16"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Make new report", style: .plain, target: self, action: #selector(addTapped))
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    @objc
    func testSession() {
        let modalViewController = AddDamageViewController()
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.title = "Test"
        self.present(modalViewController, animated: true, completion: nil)
        modalViewController.preferredContentSize = CGSize(width: 500, height: 500)
    }
    
    @objc
    func addTapped() {
        isAdding.toggle()
        self.tabBarController?.navigationItem.rightBarButtonItem?.title = isAdding ? "Cancel" : "Make new report"
    }
    
    @objc
    func saveSession() {
        debugPrint("Saving damage")
        do {
            try coreDataContext.save()
        } catch {
            debugPrint(error)
        }
    }
    
    func loadSession() {
        guard let damageNodeArray = aircraft?.damageNodeArray else { return }
        for damageNode in damageNodeArray {
            addDamage(with: damageNode)
        }
    }
    
    /// Setup of the contraints fot this viewcontroller. This is the placement of the items.
    private func setupConstraints() {
        // sceneViewConstraints
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sceneView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sceneView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let marginGuide = view.layoutMarginsGuide
        // messageLabelConstraints
        NSLayoutConstraint.activate([
            messageView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -50),
            messageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            messageLabel.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -10),
            messageLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 10),
            messageLabel.leftAnchor.constraint(equalTo: messageView.leftAnchor, constant: 10),
            messageLabel.rightAnchor.constraint(equalTo: messageView.rightAnchor, constant: -10),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
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
        
        NSLayoutConstraint.activate([
            testButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            testButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    @objc
    func tapped(sender: UITapGestureRecognizer) {
        let tappedLocation = sender.location(in: sceneView)
        if hasAddedPlane {
            if isAdding {
                if let hit = sceneView.hitTest(tappedLocation, options: nil).first {
                    
                    f16Object.enumerateChildNodes { (node, _) in
                        if hit.node == node {

                            let damageNode = DamageNode.init(context: coreDataContext)
                            let damageCoordinates = Coordinates.init(context: coreDataContext)
                            
                            damageCoordinates.x = hit.localCoordinates.x
                            damageCoordinates.y = hit.localCoordinates.y
                            damageCoordinates.z = hit.localCoordinates.z
                            
                            damageNode.coordinates = damageCoordinates
                            damageNode.createdAt = Date()
                            damageNode.addToAircraft(aircraft ?? Aircraft())
                            addDamage(with: damageNode)
//                            debugPrint("Hit f-16")
                        }
                    }
                }
            }
        } else {
            let hitTest = sceneView.hitTest(tappedLocation, types: .featurePoint)
            if !hitTest.isEmpty {
                sceneView.scene.rootNode.addChildNode(f16Object)
                
                loadSession()
                
                hasAddedPlane = true
                
            } else {
                print("nope")
            }
        }
    }
    
    @objc
    func pinched(sender: UIPinchGestureRecognizer) {
        let pinchedLocation = sender.location(in: sceneView)
        
        if let hit = sceneView.hitTest(pinchedLocation).first {
            if hit.node.name == "damage" {
                let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
                hit.node.runAction(pinchAction)
                sender.scale = 1.0
            }
        }
    }
    
    func addDamage(with damage: DamageNode) {
        
        let damagePlane = SCNPlane(width: 0.5, height: 0.5)
        damagePlane.cornerRadius = 1
        
        let damageNode = SCNNode(geometry: damagePlane)
        
        guard let coordinates = damage.coordinates else { return }
        
        damageNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        damageNode.position = SCNVector3(coordinates.x, coordinates.y, coordinates.z)
        damageNode.eulerAngles.x = -.pi / 2
        damageNode.name = "damage"
        
        
        self.sceneView.scene.rootNode.childNode(withName: "F-16", recursively: false)?.addChildNode(damageNode)
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
        if hasAddedPlane {
            let resetCoordinates: [Float] = []
            UserDefaults.standard.set(resetCoordinates, forKey: "damageCoordinates")
        }
        self.sceneView.delegate = self
        self.sceneView.session.delegate = self
        self.hasAddedPlane = false
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
                    self.messageLabel.text = ("Detected object “\(nameScannedObject)”")
                }
                
                print(anchor.transform.columns)
                
                
                if self.hasAddedPlane == true {
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
}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    
}
