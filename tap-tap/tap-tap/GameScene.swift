//
//  GameScene.swift
//  tap-tap
//
//  Created by SpriteMedia on 3/17/20.
//  Copyright © 2020 SpriteMedia. All rights reserved.
//

import SpriteKit
import GameplayKit
import os.log

class GameScene: SKScene
{
    //Timer
    var timerBar : SKSpriteNode = SKSpriteNode()
    var timerBarBG : SKSpriteNode = SKSpriteNode()
    var time = 10.0
    
    // Main Images
    var toWin : SKSpriteNode = SKSpriteNode()
    var toLose : SKSpriteNode = SKSpriteNode()

    
    // Goal
    var goalBG = SKSpriteNode()
    var goalNum : Int = 0
    var goalArray = [Int]()
    var goalImageContainer = [SKSpriteNode]()
    var goalLabelCointainer = [SKLabelNode]()
        
    //Engine
    var previousTimeInterval : TimeInterval = 0
    
    //Setting
    var settingButton : SKSpriteNode = SKSpriteNode()
    var setting : SettingScreen?
    
    var BGM : SKAudioNode = SKAudioNode()
    
    override func didMove(to view: SKView) {
        //initialize nodes
        //temp for m2 only
        toWin = SKSpriteNode(texture: SKTexture(imageNamed: "CIRCLE"))
        toWin.scale(to: CGSize(width: WIDTH*0.2, height: WIDTH*0.2))
        toWin.position = CGPoint(x : WIDTH*0.3, y : HEIGHT*0.5)
        toWin.zPosition = 5
        addChild(toWin)
        
        toLose = SKSpriteNode(texture: SKTexture(imageNamed: "HEXAGON"))
        toLose.scale(to: CGSize(width: WIDTH*0.2, height: WIDTH*0.2))
        toLose.position = CGPoint(x : WIDTH*0.7, y : HEIGHT*0.5)
        toLose.zPosition = 5
        addChild(toLose)
        
        CreateUI()
        GameTimer()
        CreateGoal()
        setting = SettingScreen(_parent: self)
        
        BGM = SKAudioNode(fileNamed: "bensound-littleidea")
        BGM.autoplayLooped = true
        BGM.run(SKAction.changeVolume(to:1.0, duration:0.0))
        BGM.run(SKAction.play())
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

//MARK: Initialization
extension GameScene {
    
    func CreateUI()
    {
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "bg_big_yellow"))
        bg.scale(to: CGSize(width: WIDTH, height: HEIGHT))
        bg.position = CGPoint(x : 0, y: 0)
        bg.zPosition = -1
        addChild(bg)
        
        let timerBG : SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "CasualUI_15_2"))
        timerBG.scale(to: CGSize(width: WIDTH, height: HEIGHT * 0.2))
        timerBG.position = CGPoint(x : 0, y : (timerBG.size.height * 0.5))
        timerBG.zPosition = 2
        addChild(timerBG)
        
        let timerFrame : SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "CasualUI_5_4"))
        timerFrame.scale(to: CGSize(width: WIDTH, height: HEIGHT * 0.1))
        timerFrame.position = CGPoint(x : 0, y : timerBG.position.y - (timerBG.size.height*0.5) + (timerFrame.size.height*0.5))
        timerFrame.zPosition = 5
        addChild(timerFrame)
        
        timerBar = SKSpriteNode(texture: SKTexture(imageNamed: "CasualUI_5_3"))
        timerBar.scale(to: CGSize(width: timerFrame.size.width * 0.96, height: timerFrame.size.height*0.9))
        timerBar.position = CGPoint(x: 0.03, y: timerFrame.position.y)
        timerBar.zPosition = 4
        timerBar.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        addChild(timerBar)
        
        timerBarBG = SKSpriteNode(texture: SKTexture(imageNamed: "CasualUI_5_2"))
        timerBarBG.scale(to: CGSize(width: timerFrame.size.width * 0.96, height: timerFrame.size.height*0.9))
        timerBarBG.position = timerFrame.position
        timerBarBG.zPosition = 3
        addChild(timerBarBG)
                	
        goalBG = SKSpriteNode(texture: SKTexture(imageNamed: "CasualUI_15_2"))
        goalBG.scale(to: CGSize(width: WIDTH, height: HEIGHT*0.2))
        goalBG.position = CGPoint(x : 0.5, y: goalBG.size.height*0.5)
        goalBG.zPosition = 1
        addChild(goalBG)
        
        settingButton = SKSpriteNode(texture : SKTexture(imageNamed: "CasualUI_6_5"))
        settingButton.scale(to: CGSize(width: WIDTH*0.1, height: WIDTH * 0.1))
        settingButton.position = CGPoint(x: 0.1, y: HEIGHT - (WIDTH*0.1))
        settingButton.zPosition = 10
        settingButton.color = SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        settingButton.colorBlendFactor = 1.0
        addChild(settingButton)
    }
    
    func CreateGoal() {
        
        //Set number of Images to Draw
        var level = Data.currentLevel
        if level > 20 {
            level = 20
        }
        goalNum = 2 + (Int)(level/5) // number of goal iamges (min: 2 to 6 images)
        
        //Copy string array of apple
        var appleNameArray = [String]()
        for name in Data.apple {
            appleNameArray.append(name)
        }
        var pickedAppleIndex = -1
        
        //Create Images
        for n in 0 ..< goalNum {
            goalArray.append(Int.random(in: 2 ... 5))//number that need to be pressed for each image (min 2 to 5 times)
            
            pickedAppleIndex = Int.random(in: 0 ..< APPLE.maxNum - n)
            let goalImage = SKSpriteNode(texture: SKTexture(imageNamed: appleNameArray[pickedAppleIndex]))
            appleNameArray.remove(at: pickedAppleIndex)
            
            goalBG.addChild(goalImage)
            goalImage.scale(to: CGSize(width: goalBG.size.width / 11, height: goalBG.size.width / 11))
            goalImage.position = CGPoint(x: goalBG.size.width/8 * CGFloat(n) - goalBG.size.width/3 , y: -goalBG.size.height/10)
            goalImage.zPosition = 5
            goalImageContainer.append(goalImage)

        }

    }
}

//MARK: Action
extension GameScene {
    
    func GameTimer() {
        
        let reduce = SKAction.scale(to: CGSize(width: 0.0, height: HEIGHT * 0.09), duration: self.time)
        timerBar.run(reduce)
        
        Timer.scheduledTimer(withTimeInterval: self.time, repeats: false) { (timer) in
            os_log("time's up")
            self.Lose()
        }
    }
    
    func Win() {
        let win = SKScene(fileNamed: "LevelClearScene")
        win?.scaleMode = .aspectFill
        view?.presentScene(win)
    }
    
    func Lose() {
        let win = SKScene(fileNamed: "GameoverScene")
        win?.scaleMode = .aspectFill
        view?.presentScene(win)
    }
}

//MARK: Game Loop
extension GameScene {
    
    override func update(_ currentTime: TimeInterval)
    {
        let deltaTime = currentTime - previousTimeInterval
        previousTimeInterval = currentTime
    }
}

//MARK: Touch
extension GameScene {
    
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
               else if(toWin.contains(t.location(in: self)))
               {
                   Win()
               }
               else if(toLose.contains(t.location(in: self)))
               {
                   Lose()
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
}
