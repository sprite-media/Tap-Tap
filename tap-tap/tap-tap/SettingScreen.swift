//
//  SettingScreen.swift
//  tap-tap
//
//  Created by SpriteMedia on 3/19/20.
//  Copyright © 2020 SpriteMedia. All rights reserved.
//

import SpriteKit

class SettingScreen
{
    var parent : SKScene?
    var bg : SKSpriteNode = SKSpriteNode()
    var audioIcon_bgm : SKSpriteNode = SKSpriteNode()
    var audioIcon_sfx : SKSpriteNode = SKSpriteNode()
    var slider_bgm : Slider?
    var slider_sfx : Slider?
    var label_bgm : SKLabelNode = SKLabelNode(fontNamed: "Menlo-Bold")
    var label_sfx : SKLabelNode = SKLabelNode(fontNamed: "Menlo-Bold")
    var title : SKLabelNode = SKLabelNode(fontNamed: "Menlo-Bold")
    var back : SKSpriteNode = SKSpriteNode()
    var buttonLabel : SKLabelNode = SKLabelNode(fontNamed: "Menlo-Bold")
    

    init(_parent : SKScene)
    {
        parent = _parent
        bg = SKSpriteNode(texture: SKTexture(imageNamed: "combinedBG"))
        bg.scale(to: CGSize(width: WIDTH*0.8, height: HEIGHT*0.8))
        bg.position = CGPoint(x : WIDTH*0.5, y : HEIGHT * 0.5)
        bg.zPosition = 10
        
        let x : CGFloat = bg.position.x - (bg.size.width*0.5) + WIDTH*0.1
        let y : CGFloat = bg.position.y
        
        audioIcon_bgm = SKSpriteNode(texture: SKTexture(imageNamed: "audio_icon"))
        audioIcon_bgm.scale(to: CGSize(width: WIDTH*0.1, height: WIDTH*0.1))
        audioIcon_bgm.position = CGPoint(x : x + audioIcon_bgm.size.width, y : y+audioIcon_bgm.size.height*2)
        audioIcon_bgm.zPosition = 11
        
        audioIcon_sfx = SKSpriteNode(texture: SKTexture(imageNamed: "audio_icon"))
        audioIcon_sfx.scale(to: CGSize(width: WIDTH*0.1, height: WIDTH*0.1))
        audioIcon_sfx.position = CGPoint(x : x + audioIcon_bgm.size.width, y : y-audioIcon_sfx.size.height*2)
        audioIcon_sfx.zPosition = 11
        
        let sliderX : CGFloat = x + audioIcon_bgm.size.width + (WIDTH*0.05) + (WIDTH * 0.2)
        
        slider_bgm = Slider(_parent : parent!)
        slider_bgm!.size = CGSize(width: WIDTH*0.4, height: WIDTH*0.12)
        slider_bgm!.position = CGPoint(x : sliderX, y : audioIcon_bgm.position.y)
        slider_bgm!.value = 1
        slider_bgm!.zPosition = 11
        
        slider_sfx = Slider(_parent : parent!)
        slider_sfx!.size = CGSize(width: WIDTH*0.4, height: WIDTH*0.12)
        slider_sfx!.position = CGPoint(x : sliderX, y : audioIcon_sfx.position.y)
        slider_sfx!.value = 1
        slider_sfx!.zPosition = 11
        
        label_bgm.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        label_bgm.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        label_bgm.position = CGPoint(x : slider_bgm!.position.x, y: slider_bgm!.position.y + slider_bgm!.size.height)
        label_bgm.text = "BGM"
        label_bgm.fontColor = UIColor.black
        label_bgm.zPosition = 11
        
        label_sfx.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        label_sfx.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        label_sfx.position = CGPoint(x : slider_sfx!.position.x, y: slider_sfx!.position.y + slider_sfx!.size.height)
        label_sfx.text = "SFX"
        label_sfx.fontColor = UIColor.black
        label_sfx.zPosition = 11
        
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        title.position = CGPoint(x : WIDTH * 0.5, y : (HEIGHT * 0.5) + (bg.size.height*0.41))
        title.text = "Settings"
        title.fontColor = UIColor.black
        title.zPosition = 11
        
        back = SKSpriteNode(texture: SKTexture(imageNamed: "OrangeButton"))
        back.scale(to: CGSize(width: WIDTH * 0.3, height: HEIGHT * 0.1))
        back.position = CGPoint(x : WIDTH * 0.5, y : bg.position.y - bg.size.height*0.3)
        back.zPosition = 11
        
        buttonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        buttonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        buttonLabel.position = back.position
        buttonLabel.text = "BACK"
        buttonLabel.fontColor = UIColor.black
        buttonLabel.zPosition = 12
    }
    
    func Show(visible : Bool)
    {
        if(visible)
        {
            parent!.addChild(bg)
            parent!.addChild(audioIcon_bgm)
            parent!.addChild(audioIcon_sfx)
            parent!.addChild(title)
            parent!.addChild(back)
            parent!.addChild(buttonLabel)
            parent!.addChild(label_bgm)
            parent!.addChild(label_sfx)
            slider_bgm!.AddToScene()
            slider_sfx!.AddToScene()
        }
        else
        {
            bg.removeFromParent()
            audioIcon_bgm.removeFromParent()
            audioIcon_sfx.removeFromParent()
            title.removeFromParent()
            back.removeFromParent()
            buttonLabel.removeFromParent()
            label_bgm.removeFromParent()
            label_sfx.removeFromParent()
            
            slider_bgm!.RemoveFromParent()
            slider_sfx!.RemoveFromParent()
        }
    }
}
