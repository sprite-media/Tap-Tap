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
        self.backgroundColor = SKColor.white
        CreateSwiftAndSpriteKitLogo()
    }
    
   func CreateTeamLogo()
   {
        let teamLogoNode = SKSpriteNode(texture: SKTexture(imageNamed: "logo_spritemedia"))
        teamLogoNode.size.width = self.frame.size.width
        teamLogoNode.size.height = self.frame.size.height/2
        teamLogoNode.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        teamLogoNode.alpha = 0
        let teamLogoAction =   SKAction.sequence([SKAction.fadeIn(withDuration: 2.0), SKAction.fadeOut(withDuration: 2.0)])
        self.addChild(teamLogoNode)
    
        teamLogoNode.run(teamLogoAction, completion: self.ChangeScene)
    }
    func CreateSwiftAndSpriteKitLogo()
    {
        let logos = SKNode()
        logos.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        logos.alpha = 0
        self.addChild(logos)
        
        let swiftLogoNode = SKSpriteNode(texture: SKTexture(imageNamed: "logo_swift"))
        swiftLogoNode.size.width = self.frame.size.width/1.5
             swiftLogoNode.size.height = self.frame.size.height/3
             swiftLogoNode.position = CGPoint(x: 0, y: self.frame.height/5)
        logos.addChild(swiftLogoNode)
        
        let spriteKitLogoNode = SKSpriteNode(texture: SKTexture(imageNamed: "logo_spritekit"))
        spriteKitLogoNode.size.width = self.frame.size.width/1.5
        spriteKitLogoNode.size.height = self.frame.size.height/3
        spriteKitLogoNode.position = CGPoint(x: 0, y: -self.frame.height/5)
        logos.addChild(spriteKitLogoNode)
        
        let logosAction = SKAction.sequence([SKAction.fadeIn(withDuration: 2.0), SKAction.fadeOut(withDuration: 2.0)])
        logos.run(logosAction, completion: self.CreateTeamLogo)
    }
    func ChangeScene()
    {
        if let view = self.view
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
