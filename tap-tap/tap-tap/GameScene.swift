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
    var settingButton : SKSpriteNode = SKSpriteNode()
    var setting : SettingScreen?
    
    var BGM : SKAudioNode = SKAudioNode()
    
    override init(size: CGSize)
    {
        super.init(size: size)
        //initialize nodes
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "bg_big_yellow"))
        bg.scale(to: CGSize(width: WIDTH, height: HEIGHT))
        bg.position = CGPoint(x : WIDTH * 0.5, y: HEIGHT * 0.5)
        bg.zPosition = -1
        addChild(bg)
        
        settingButton = SKSpriteNode(texture : SKTexture(imageNamed: "CasualUI_6_5"))
        settingButton.scale(to: CGSize(width: WIDTH*0.1, height: WIDTH * 0.1))
        settingButton.position = CGPoint(x: WIDTH * 0.1, y: HEIGHT - (WIDTH*0.2))
        settingButton.zPosition = 10
        addChild(settingButton)
        
        setting = SettingScreen(_parent: self)
        
        BGM = SKAudioNode(fileNamed: "bensound-littleidea")
        BGM.autoplayLooped = true
        BGM.run(SKAction.changeVolume(to:1.0, duration:0.0))
        BGM.run(SKAction.play())
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init has not been implemented.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches
        {
            if(settingButton.contains(t.location(in: self)))
            {
                setting!.Show(visible: true)
                settingButton.removeFromParent()
            }
            else if(setting!.back.contains(t.location(in: self)))
            {
                setting!.Show(visible: false)
                addChild(settingButton)
            }
            setting!.slider_bgm!.ValueChange(touchPoint: t.location(in: self), function : ChangeBGMVolume)
            setting!.slider_sfx!.ValueChange(touchPoint: t.location(in: self), function : ChangeSFXVolume)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches
        {
            setting!.slider_bgm!.ValueChange(touchPoint: t.location(in: self), function : ChangeBGMVolume)
            setting!.slider_sfx!.ValueChange(touchPoint: t.location(in: self), function : ChangeSFXVolume)

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches
        {
            setting!.slider_bgm!.ValueChange(touchPoint: t.location(in: self), function : ChangeBGMVolume)
            setting!.slider_sfx!.ValueChange(touchPoint: t.location(in: self), function : ChangeSFXVolume)

        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches
        {
            setting!.slider_bgm!.ValueChange(touchPoint: t.location(in: self), function : ChangeBGMVolume)
            setting!.slider_sfx!.ValueChange(touchPoint: t.location(in: self), function : ChangeSFXVolume)

        }
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
    
    func ChangeBGMVolume(vol : Float)
    {
        print(vol)
        BGM.run(SKAction.changeVolume(to:vol, duration:0.0))
    }
    func ChangeSFXVolume(vol : Float)
    {
        print(vol)
        //change to sfx BGM.run(SKAction.changeVolume(to:vol, duration:0.0))
    }
}
