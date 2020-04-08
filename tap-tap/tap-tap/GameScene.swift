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
    //BG
    var bg : SKNode?
    var timerBg : SKNode?
    var goalBg : SKNode?
    
    //Timer
    var timerBar : SKNode?
    var timerBarBg : SKNode?
    var time = 10.0
    
    // Main Images
    var toWin : SKSpriteNode = SKSpriteNode()
    var toLose : SKSpriteNode = SKSpriteNode()

    
    // Goal
    var goalNum : Int = 0
    var goalArray = [Int]()
    var goalImageContainer = [SKSpriteNode]()
    var goalLabelCointainer = [SKLabelNode]()
        
    //Engine
    var previousTimeInterval : TimeInterval = 0
    
    //Setting
    var settingButton : SKNode?
    var setting : SettingScreen?
    
    var BGM : SKAudioNode = SKAudioNode()
    
    override func didMove(to view: SKView) {
        //initialize nodes
        bg = childNode(withName: "bg")
        timerBg = bg?.childNode(withName: "timerBg")
        goalBg = bg?.childNode(withName: "goalBg")
        timerBar = timerBg?.childNode(withName: "timerBar")
        timerBarBg = timerBg?.childNode(withName: "timerBarBg")
        settingButton = timerBg?.childNode(withName: "settingButton")
        
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
            
            goalBg?.addChild(goalImage)
            goalImage.scale(to: CGSize(width: goalBg!.xScale / 11, height: goalBg!.xScale / 11))
            goalImage.position = CGPoint(x: goalBg!.xScale / 8 * CGFloat(n) - goalBg!.xScale / 3 , y: -goalBg!.yScale / 10)
            goalImage.zPosition = 5
            goalImageContainer.append(goalImage)

        }

    }
}

//MARK: Action
extension GameScene {
    
    func GameTimer() {
        
        let reduce = SKAction.scale(to: CGSize(width: 0.0, height: HEIGHT * 0.09), duration: self.time)
        timerBar?.run(reduce)
        
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
               if(settingButton!.contains(t.location(in: self)))
               {
                    setting!.Show(visible: true)
                    settingButton!.removeFromParent()
               }
               else if(setting!.back.contains(t.location(in: self)))
               {
                    setting!.Show(visible: false)
                    addChild(settingButton!)
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
