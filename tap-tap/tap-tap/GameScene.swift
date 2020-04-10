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
    var time = 20.0
    
    // Main Images
    var toWin : SKSpriteNode = SKSpriteNode()
    var toLose : SKSpriteNode = SKSpriteNode()

    
    // Goal
    var goalNum : Int = 0
    var goalNumArray = [Int]()
    var goalTypeArray = [APPLE]()
    var unPickedGoalArray = [APPLE]()
    var goalImageContainer = [SKSpriteNode]()
    var goalLabelCointainer = [SKLabelNode]()
    
    // Apple
    var appleArray = [APPLE]()
    var appleSpriteArray = [SKSpriteNode]()
        
    //Engine
    var previousTimeInterval : TimeInterval = 0
    var isPause: Bool = true
    var isPanelExcist : Bool = true
    var isTouching = false
    var isGameStarted = false
    var panel : SKNode?
    
    //Setting
    var settingButton : SKSpriteNode = SKSpriteNode()
    var setting : SettingScreen?
    

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
        
        Pause(b: isPause)

        setting = SettingScreen(_parent: self)
        

    }
    
    func ChangeBGMVolume(vol : Float)
    {
        print(vol / 2)
        SoundManager.shared.bgm.setVolume(vol / 2, fadeDuration: 0.0)

    }
    func ChangeSFXVolume(vol : Float)
    {
        print(vol / 2)
        SoundManager.shared.sfx.setVolume(vol / 2, fadeDuration: 0.0)
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
            goalTypeArray.append(APPLE(rawValue: appleNameArray[pickedAppleIndex])!)
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
                randNum = Int.random(in: 2 ... 4)
            }
            
            goalNumArray.append(randNum)//number that need to be pressed for each image
            let goalLabel = SKLabelNode()
            goalLabel.position = CGPoint(x: goalImage.position.x, y: self.frame.height * 0.04)
            goalLabel.zPosition = 5
            goalLabel.fontColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            goalLabel.fontSize = 48
            goalLabel.fontName = "MarkerFelt-Thin"
            goalLabel.horizontalAlignmentMode = .center
            goalLabel.text = String("\(goalNumArray[n])")
            goalLabel.alpha = 0.7
            goalBg?.addChild(goalLabel)
            goalLabelCointainer.append(goalLabel)
        }
        
        for apple in appleNameArray {
            unPickedGoalArray.append(APPLE(rawValue: apple)!)
        }
    }
}

//MARK: Action
extension GameScene {

    func CreateApples() {
        
        for apple in appleSpriteArray {
            apple.removeFromParent()
        }
        appleSpriteArray.removeAll()
        appleArray.removeAll()
        
        //Store apple in an array
        let tempUnPickedGoalArray = unPickedGoalArray
        for n in 0 ... 5 {
            if(n < goalTypeArray.count) {
                appleArray.append(goalTypeArray[n])
            } else {
                let pickedAppleIndex = Int.random(in: 0 ..< tempUnPickedGoalArray.count)
                let randomApple = APPLE(rawValue: tempUnPickedGoalArray[pickedAppleIndex].rawValue)
                appleArray.append(randomApple!)
            }
        }
        
        //Mix
        appleArray.shuffle()
        
        //Draw
        for n in 0 ... 5 {
            let image = SKSpriteNode(texture: SKTexture(imageNamed: appleArray[n].rawValue))
            image.size = CGSize(width: self.frame.width / 6, height: self.frame.width / 6)
            let verticalGap = (self.frame.height / 5)
            if(n < 3) { //0,1,2
                image.position.x = self.frame.width / -5
            } else { //3,4,5
                image.position.x = self.frame.width / 5
            }
            image.position.y = verticalGap - ((CGFloat(Int(n % 3)) * verticalGap))
            
            image.zPosition = 5
            //image.position = CGPoint(x: 0, y: 0)
            appleSpriteArray.append(image)
            addChild(appleSpriteArray[n])
        }

    }
    
    func Pause(b : Bool){
        timerBar?.isPaused = b
        settingButton.isPaused = b
    }
    
    func GameTimer() {
        let reduce = SKAction.scale(to: CGSize(width: 0.0, height: HEIGHT * 0.09), duration: self.time)
        timerBar?.run(reduce)

    }

    
    func Win() {
        Data.currentLevel += 1
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

        for n in goalNumArray {
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
    
    override func update(_ currentTime: TimeInterval) {
        if isGameStarted {
            WinLoseCheck()
        }
    }
}

//MARK: Touch
extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches
        {
            if !isTouching {
                isTouching = true
                SoundManager.shared.PlaySfx(soundName: "clickSoundMp3Version")
                
                if(isPanelExcist)
                {
                    isPause = false
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {(timer) in
                        self.Pause(b: self.isPause)
                        self.CreateUI()
                        self.CreateGoal()
                        self.CreateApples()
                        self.GameTimer()
                        self.isGameStarted = true
                        self.panel?.removeFromParent()
                    }
                    
                    isPanelExcist = false
                    let fadeOut = SKAction.fadeOut(withDuration: 1)
                    panel?.run(fadeOut)
                }
             
           
                for i in 0 ..< appleSpriteArray.count {
                    if appleSpriteArray[i].contains(t.location(in: self)) {
                        var touchCorrectApple = false
                        for j in 0 ..< goalTypeArray.count {
                            if appleArray[i] == goalTypeArray[j] {
                                goalNumArray[j] -= 1
                                if goalNumArray[j] > 0 {
                                    goalLabelCointainer[j].text = "\(goalNumArray[j])"
                                }
                                else {
                                    goalNum -= 1
                                    unPickedGoalArray.append(goalTypeArray[j])
                                    goalTypeArray.remove(at: j)
                                    goalLabelCointainer[j].text = ""
                                    let xMark = SKSpriteNode(texture : SKTexture(imageNamed: "CasualUI_7_3"))
                                    goalImageContainer[j].addChild(xMark)
                                    xMark.zPosition = 6
                                    xMark.position = CGPoint(x: 0, y: 0)
                                    xMark.size = CGSize(width: goalImageContainer[j].size.width * 1.1, height: goalImageContainer[j].size.width)
                                }
                                CreateApples()
                                touchCorrectApple = true
                                break;
                            }
                        }
                        if !touchCorrectApple {
                            Lose()
                        }
                    }
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
                
            if isTouching {
                isTouching = false
            }

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
