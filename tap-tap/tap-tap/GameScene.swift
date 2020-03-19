//
//  GameScene.swift
//  tap-tap
//
//  Created by SpriteMedia on 3/17/20.
//  Copyright © 2020 SpriteMedia. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    var setting : SettingScreen?
    
    override init(size: CGSize)
    {
        super.init(size: size)
        //initialize nodes
        setting = SettingScreen(_parent: self)
        setting!.Show(visible: true)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init has not been implemented.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches
        {
            setting!.slider_bgm!.ValueChange(touchPoint: t.location(in: self))
            setting!.slider_sfx!.ValueChange(touchPoint: t.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches
        {
            setting!.slider_bgm!.ValueChange(touchPoint: t.location(in: self))
            setting!.slider_sfx!.ValueChange(touchPoint: t.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches
        {
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches
        {
        }
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
}
