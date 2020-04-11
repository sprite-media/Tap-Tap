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
        SoundManager.shared.StartBackgroundMusic(soundName: "bensound-littleidea")
        SoundManager.shared.bgm.setVolume(0.5, fadeDuration: 0.0)
        
        self.backgroundColor = SKColor.white
        Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false) {(timer) in
            self.removeAllActions()
            self.removeAllChildren()
            let gameScene = SKScene(fileNamed: "GameScene")
            gameScene?.scaleMode = .aspectFit
            view.presentScene(gameScene)
        }
    }
}
