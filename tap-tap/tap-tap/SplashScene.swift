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
    override init(size: CGSize)
    {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView)
    {
       CreateTeamLogo()
    }
    
   func CreateTeamLogo()
   {
        let teamLogoNode = SKSpriteNode(texture: SKTexture(imageNamed: "logo_spritemedia"))
        teamLogoNode.size = self.frame.size
        teamLogoNode.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        teamLogoNode.alpha = 0
        let teamLogoAction =   SKAction.sequence([SKAction.fadeIn(withDuration: 2.0), SKAction.fadeOut(withDuration: 2.0)])
        self.addChild(teamLogoNode)
    
        teamLogoNode.run(teamLogoAction, completion: self.CreateSwiftLogo)
    }
    func CreateSwiftLogo()
    {
        let swiftLogoNode = SKSpriteNode(texture: SKTexture(imageNamed: "logo_swift"))
             swiftLogoNode.size.width = self.frame.size.width/2
             swiftLogoNode.size.height = self.frame.size.height/3
             swiftLogoNode.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
             swiftLogoNode.alpha = 0
             let swiftLogoAction = SKAction.sequence([SKAction.fadeIn(withDuration: 2.0), SKAction.fadeOut(withDuration: 2.0)])
             swiftLogoNode.run(swiftLogoAction)
        self.addChild(swiftLogoNode)
        
        swiftLogoNode.run(swiftLogoAction, completion: self.CreateSpriteKitLogo)
    }
    func CreateSpriteKitLogo()
    {
        let spriteKitLogoNode = SKSpriteNode(texture: SKTexture(imageNamed: "logo_spritekit"))
        spriteKitLogoNode.size.width = self.frame.size.width/2
        spriteKitLogoNode.size.height = self.frame.size.height/3
        spriteKitLogoNode.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        spriteKitLogoNode.alpha = 0
        let spriteKitLogoAction = SKAction.sequence([SKAction.fadeIn(withDuration: 2.0), SKAction.fadeOut(withDuration: 2.0)])
        self.addChild(spriteKitLogoNode)
        
        spriteKitLogoNode.run(spriteKitLogoAction, completion: ChangeScene)

    }
    func ChangeScene()
    {
        if let view = self.view as! SKView?
        {
                   
            let gameScene = GameScene(size: (self.view?.frame.size)!)
                       gameScene.scaleMode = .aspectFill
            // Present the scene
            view.presentScene(gameScene)
            view.ignoresSiblingOrder = true
            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init has not been implemented.")
    }
}
