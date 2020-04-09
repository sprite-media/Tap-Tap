//
//  SplashScene.swift
//  tap-tap
//
//  Created by SpriteMedia on 3/17/20.
//  Copyright © 2020 SpriteMedia. All rights reserved.
//

import SpriteKit

class SplashScene : SKScene
{
    override func didMove(to view: SKView)
    {
        SoundManager.shared.StartBackgroundMusic()
        self.backgroundColor = SKColor.white
        //CreateSwiftAndSpriteKitLogo()
        Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false) {(timer) in
            self.removeAllActions()
            self.removeAllChildren()
            let gameScene = SKScene(fileNamed: "GameScene")
            gameScene?.scaleMode = .aspectFit
            view.presentScene(gameScene)
        }
    }
}
