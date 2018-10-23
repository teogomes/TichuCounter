//
//  ViewController.swift
//  ARScanner
//
//  Created by Teodoro Gomes on 21/10/2018.
//  Copyright © 2018 Teodoro Gomes. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        guard let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "Photos", bundle: Bundle.main) else {
            print("no Images")
            return
        }
        
        configuration.trackingImages = trackedImages
        configuration.maximumNumberOfTrackedImages = 6
        
        configuration.isLightEstimationEnabled = true;
        //object detection 
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        

        
        if let imageAnchor = anchor as? ARImageAnchor{
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            
            
            if(imageAnchor.name! == "KB" || imageAnchor.name! == "KM" || imageAnchor.name! == "KP"){
                score += 10
                DispatchQueue.global(qos: .utility).async {
                    self.updateScoreLabel()
                }
                count += 1
            }
            if imageAnchor.name! == "dragon" {
                score += 25
                DispatchQueue.global(qos: .utility).async {
                    self.updateScoreLabel()
                }
                count += 1
            }
           
            if imageAnchor.name! == "phoenix"{
                score -= 25
                DispatchQueue.global(qos: .utility).async {
                    self.updateScoreLabel()
                }
                count += 1
            }
            
            if imageAnchor.name! == "5M" {
                score += 5
                DispatchQueue.global(qos: .utility).async {
                    self.updateScoreLabel()
                }
                count += 1
                
            }
            
            if count == 6 {
                print("calced")
            }
            print(count)
        }
        
        return node
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        sceneView.session.run(session.configuration!,
                              options: [.resetTracking,
                                        .removeExistingAnchors])
    }
    
    
    @IBAction func resetScore(_ sender: UIButton) {
        
            score = 0
        count = 0
            updateScoreLabel()

//            Pause Session
            sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                node.removeFromParentNode() }
            sceneView.session.pause()
            blur.isHidden = false
       
      
        
        
    }
    
    @IBAction func startSession(_ sender: UIButton) {
        blur.isHidden = true
        sessionInterruptionEnded(sceneView.session)
    }
    
    
    func updateScoreLabel(){
        DispatchQueue.main.async {
            self.scoreLabel.text = "Score: \(self.score)"
        }
       
    }
    
  
    @IBAction func returnView(_ sender: UIButton) {
        let i = navigationController?.viewControllers.index(of: self)
        let previousViewController = navigationController?.viewControllers[i!-1] as! CounterViewController
        
        if previousViewController.buttonTag == 1 {
            previousViewController.team1Score.text = String(score)
            previousViewController.Score1Changed(self)
            
        }else if previousViewController.buttonTag == 2{
            previousViewController.team2Score.text = String(score)
            previousViewController.Score2Changed(self)
        }
       
        
        navigationController?.popViewController(animated: true)
    }
    
}
