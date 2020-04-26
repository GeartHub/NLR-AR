//
//  ViewController.swift
//  NLR AR
//
//  Created by Geart Otten on 02/04/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".serialSceneKitQueue")
    
    var sceneView = ARSCNView()
    
    var messageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Autoresizing is the automatic contraints of Apple, we dont want that.
        self.sceneView.translatesAutoresizingMaskIntoConstraints = false
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup of sceneView
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.automaticallyUpdatesLighting = true
        self.sceneView.delegate = self
        
        self.title = "World tracking"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Adding the items to the View
        view.addSubview(sceneView)
        view.addSubview(messageLabel)
        
        restartSession()
        setupConstraints()
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
    }
    
    /// This function restarts the AR session so everything is ready to go again.
    private func restartSession() {
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        guard let referenceObjects = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources", bundle: nil) else { return }
        
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        configuration.detectionObjects = referenceObjects
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
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
                }
                
                
                
    //                if imageName == "Windmill" {
    //                    let windmill = SCNScene(named: "windmill.scn")!
    //                    let windmillNode = windmill.rootNode.childNode(withName: "windmill", recursively: false)!
    //
    //                    node.addChildNode(windmillNode)
    //                    let turningPoint = windmillNode.childNode(withName: "holderParent", recursively: true)
    //                    let turningAction = self.rotation(time: 4)
    //                    turningPoint?.runAction(turningAction)
    //                } else if imageName == "Transformator" {
    //                    let transformator = SCNScene(named: "transformator.scn")!
    //                    let transformatorNode = transformator.rootNode.childNode(withName: "transformator", recursively: false)!
    //                    transformatorNode.scale = SCNVector3(0.00015, 0.00015, 0.00015)
    //
    //                    node.addChildNode(transformatorNode)
    //                }
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

    //            let text = SCNText(string: "\(imageName)", extrusionDepth: 0.1)
    //            text.font = UIFont.systemFont(ofSize: 1.0)
    //            text.flatness = 0.01
    //            text.firstMaterial?.diffuse.contents = UIColor.white

    //            let textNode = SCNNode(geometry: text)
    //            let fontSize = Float(0.04)
    //
    //            textNode.scale = SCNVector3(fontSize, fontSize, fontSize)
    //            textNode.position = SCNVector3Zero
    //
    //            var minVec = SCNVector3Zero
    //            var maxVec = SCNVector3Zero
    //            (minVec, maxVec) =  textNode.boundingBox
    //            textNode.pivot = SCNMatrix4MakeTranslation(
    //                minVec.x + (maxVec.x - minVec.x)/2,
    //                minVec.y,
    //                minVec.z + (maxVec.z - minVec.z)/2
    //            )
    //
    //
    //            windmillNode.addChildNode(textNode)
    //            node.addChildNode(textNode)
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

