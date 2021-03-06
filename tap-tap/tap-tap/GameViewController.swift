//
//  GameViewController.swift
//  tap-tap
//
//  Created by SpriteMedia on 3/17/20.
//  Copyright © 2020 SpriteMedia. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

let WIDTH = UIScreen.main.bounds.width
let HEIGHT = UIScreen.main.bounds.height

class GameViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
                   // Load the SKScene from 'GameScene.sks'
                   if let scene = SKScene(fileNamed: "SplashScene") {
                       // Set the scale mode to scale to fit the window
                       scene.scaleMode = .aspectFill
                       
                       // Present the scene
                       view.presentScene(scene)
                   }
                   
                   view.ignoresSiblingOrder = false
                   
                   view.showsFPS = true
                   view.showsNodeCount = true
               }
        
        //if let view = self.view as! SKView?
        //{
        //    let scene = SplashScene(size : self.view.frame.size)
        //    scene.scaleMode = .aspectFill
            
        //    view.presentScene(scene)
        //    view.ignoresSiblingOrder = false
         //   view.showsPhysics = true;//change to false when releasing
         //   view.showsFPS = true
         //   view.showsNodeCount = true
        //}
    }

    override var shouldAutorotate: Bool
    {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return .allButUpsideDown
        }
        else
        {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
