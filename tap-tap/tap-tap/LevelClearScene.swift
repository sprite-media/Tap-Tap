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
    var button = SKSpriteNode()
    

    override func didMove(to view: SKView)
    {
        CreateLabel()
        CreateButtons()
        
    }
 
    func CreateLabel()
    {
        let levelClearLabel = SKLabelNode(fontNamed: "Menlo-Bold")
        levelClearLabel.position = CGPoint( x: self.frame.midX, y: self.frame.size.height/1.2)
        levelClearLabel.zPosition = 10
        levelClearLabel.fontSize = 36
        levelClearLabel.text = "LEVEL CLEAR"
        levelClearLabel.fontColor = UIColor.black
        self.addChild(levelClearLabel)
        
        let stageLabel = SKLabelNode(fontNamed: "Menlo-Bold")
        stageLabel.position = CGPoint( x: 0, y: 450)
        stageLabel.zPosition = 10
        stageLabel.text = "STAGE \(Data.currentLevel) CLEARED"
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
        okButton.frame = CGRect(x: 85, y: 550, width: (okImage?.size.width)!, height: (okImage?.size.height)!)
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
        let gameScene = SKScene(fileNamed: "GameScene")
        okButton.isHidden = true
        gameScene?.scaleMode = .aspectFit
        view?.presentScene(gameScene)
    }

}
