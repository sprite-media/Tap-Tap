//
//  LevelClearScene.swift
//  tap-tap
//
//  Created by heaseo chung on 2020-03-19.
//  Copyright © 2020 SpriteMedia. All rights reserved.
//

import SpriteKit

class LevelClearScene : SKScene
{
    var bg : SKSpriteNode!
    let okButton = UIButton(type: .custom)
    
    override init(size: CGSize)
    {
        super.init(size: size)
   
    }
    override func didMove(to view: SKView)
    {
        CreateBackground()
        CreateLabel()
        CreateButtons()
    }
    func CreateBackground()
    {
        bg = SKSpriteNode(texture: SKTexture(imageNamed: "bg_big_yellow.png"))
        bg.size = self.frame.size
        bg.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        bg.zPosition = -20
        addChild(bg)
    }
    func CreateLabel()
    {
        let levelClearLabel = SKLabelNode(fontNamed: "Menlo-Bold")
        levelClearLabel.position = CGPoint( x: self.frame.midX, y: self.frame.size.height/1.2)
        levelClearLabel.zPosition = 10
        levelClearLabel.text = "LEVEL CLEAR"
        levelClearLabel.fontColor = UIColor.black
        self.addChild(levelClearLabel)
        
        let stageLabel = SKLabelNode(fontNamed: "Menlo-Bold")
        stageLabel.position = CGPoint( x: self.frame.midX, y: self.frame.size.height/2)
        stageLabel.zPosition = 10
        stageLabel.text = "STAGE 1"
        stageLabel.fontColor = UIColor.black
        self.addChild(stageLabel)
    }
    func CreateButtons()
    {
        let size = CGSize(width: 200, height: 100)
        var okImage = UIImage(named: "OrangeButton.png")
        okImage = imageResize(image: okImage!, sizeChange: size)
        okButton.setBackgroundImage(okImage, for: .normal)
        okButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
               
        okButton.setTitle("NEXT", for: .normal)
        okButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 20)
        okButton.setTitleColor(UIColor.black, for: .normal)
        okButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
               
        okButton.addTarget(self, action: #selector(OKButton), for: .touchUpInside)
        okButton.frame = CGRect(x: self.frame.width/2 - (okImage?.size.width)!/2, y: self.frame.height/1.5, width: (okImage?.size.width)!, height: (okImage?.size.height)!)
                  self.view?.addSubview(okButton)
        okButton.isHidden = false
    }
    func imageResize (image:UIImage, sizeChange:CGSize)-> UIImage
    {
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen

        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    @objc func OKButton(sender: UIButton!)
    {
        if let view = self.view {
            
            let gameScene = GameScene(size: (self.view?.frame.size)!)
                gameScene.scaleMode = .aspectFill
            okButton.isHidden = true
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
