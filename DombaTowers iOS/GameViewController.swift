//
//  GameViewController.swift
//  DombaTowers iOS
//
//  Created by devon tomlin on 2023-04-22.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController
{
    
    var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove any previously added SKView
        skView?.removeFromSuperview()
        
        // Create SKView and add to view hierarchy
        skView = SKView(frame: view.bounds)
        skView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // We need to match the sprite kit view to the screens bounds
        skView.frame = view.bounds
        view.addSubview(skView)
        
        // Create GameScene and present in SKView
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        // Configure SKView properties
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

