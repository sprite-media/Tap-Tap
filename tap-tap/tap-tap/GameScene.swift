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
    var isPause: Bool = true
    var isPanelExcist : Bool = true
    var panel : SKNode?
    
    //Setting
    var settingButton : SKSpriteNode = SKSpriteNode()
    var setting : SettingScreen?
    
    var BGM : SKAudioNode = SKAudioNode()
    
    override func didMove(to view: SKView) {
        //initialize nodes
        bg = childNode(withName: "bg")
        timerBg = bg?.childNode(withName: "timerBg")
        goalBg = bg?.childNode(withName: "goalBg")
        timerBar = timerBg?.childNode(withName: "timerBar")
        timerBarBg = timerBg?.childNode(withName: "timerBarBg")
        panel = childNode(withName: "panel")
        panel?.alpha = 0.7
        panel?.zPosition = 50
        
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
        
        Pause(b: isPause)
        GameTimer()
        
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
    
    func CreateUI() {
        
        settingButton = SKSpriteNode(texture : SKTexture(imageNamed: "CasualUI_6_5"))
        settingButton.size = CGSize(width: self.frame.width / 10, height: self.frame.width / 10)
        settingButton.position = CGPoint(x: -self.frame.width/2 + self.frame.width / 15, y: self.frame.height / 2 - self.frame.width / 15)
        settingButton.zPosition = 10
        settingButton.color = SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        settingButton.colorBlendFactor = 1.0
        addChild(settingButton)
        
        let levelLabel = SKLabelNode()
        levelLabel.position = CGPoint(x: 0, y: 580)
        levelLabel.zPosition = 5
        levelLabel.fontColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        levelLabel.fontSize = 64
        levelLabel.fontName = "MarkerFelt-Thin"
        levelLabel.horizontalAlignmentMode = .center
        levelLabel.text = String("Level \(Data.currentLevel)")
        addChild(levelLabel)
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
            pickedAppleIndex = Int.random(in: 0 ..< APPLE.maxNum - n)
            let goalImage = SKSpriteNode(texture: SKTexture(imageNamed: appleNameArray[pickedAppleIndex]))
            appleNameArray.remove(at: pickedAppleIndex)
            
            goalBg?.addChild(goalImage)
            goalImage.size = CGSize(width: self.frame.width / 8, height: self.frame.width / 8)
            let gap :CGFloat = self.frame.width * 0.15
            let xPos : CGFloat = CGFloat(goalNum) / -2.0 * goalImage.size.width //gap * CGFloat(n)
            goalImage.position = CGPoint(x: xPos + gap * CGFloat(n), y: -self.frame.height * 0.02)
            goalImage.zPosition = 5
            goalImage.alpha = 0.7
            goalImageContainer.append(goalImage)
            
            var randNum : Int
            if Data.currentLevel > 80 {
                randNum = Int.random(in: 3 ... 6)
            } else if Data.currentLevel > 40 {
                randNum = Int.random(in: 2 ... 5)
            } else if goalNum >= 4 {
                randNum = Int.random(in: 1 ... 4)
            } else {
                randNum = Int.random(in: 2 ... 5)
            }
            
            goalArray.append(randNum)//number that need to be pressed for each image
            var goalLabel = SKLabelNode()
            goalLabel.position = CGPoint(x: goalImage.position.x, y: self.frame.height * 0.04)
            goalLabel.zPosition = 5
            goalLabel.fontColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            goalLabel.fontSize = 48
            goalLabel.fontName = "MarkerFelt-Thin"
            goalLabel.horizontalAlignmentMode = .center
            goalLabel.text = String("\(goalArray[n])")
            goalLabel.alpha = 0.7
            goalBg?.addChild(goalLabel)
            goalLabelCointainer.append(goalLabel)
        }
    }
}

//MARK: Action
extension GameScene {
    
    func Pause(b : Bool){
        timerBar?.isPaused = b
        settingButton.isPaused = b
    }
    
    func GameTimer() {
        let reduce = SKAction.scale(to: CGSize(width: 0.0, height: HEIGHT * 0.09), duration: self.time)
        timerBar?.run(reduce)

    }

    
    func Win() {
        Data.didWin = true
        let win = SKScene(fileNamed: "LevelClearScene")
        win?.scaleMode = .aspectFill
        view?.presentScene(win)
    }
    
    func Lose() {
        Data.didWin = false
        let win = SKScene(fileNamed: "GameoverScene")
        win?.scaleMode = .aspectFill
        view?.presentScene(win)
    }
    
    func WinLoseCheck() {
        
        var won : Bool
        if isPanelExcist {
            won = false
        } else {
            won = true
        }

        for n in goalArray {
            if n > 0 {
                won = false
                break;
            }
        }
        if won {
            Win()
        } else if timerBar!.xScale <= CGFloat(0.0) {
            Lose()
        }
    }
}

//MARK: Game Loop
extension GameScene {
    
    override func update(_ currentTime: TimeInterval)
    {
        let deltaTime = currentTime - previousTimeInterval
        previousTimeInterval = currentTime
        
        WinLoseCheck()
    }
}

//MARK: Touch
extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
       {
           for t in touches
           {
                if(isPanelExcist)
                {
                    isPause = false
                    Pause(b: isPause)
                    CreateUI()
                    CreateGoal()
                    isPanelExcist = false
                    panel?.removeFromParent()
                }
            
                if(settingButton.contains(t.location(in: self)))
                {
                    if !isPause {
                        isPause = true
                        setting!.Show(visible: isPause)
                        Pause(b: isPause)
                        settingButton.alpha = 0
                    }
                }
                else if(setting!.back.contains(t.location(in: self)))
                {
                    if isPause {
                        isPause = false
                        setting!.Show(visible: isPause)
                        Pause(b: isPause)
                        let fadeIn = SKAction.fadeIn(withDuration: 1)
                        settingButton.run(fadeIn)
                    }
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
