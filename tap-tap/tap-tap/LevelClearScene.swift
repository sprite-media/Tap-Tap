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
    let time = 1.2
    let okButton = UIButton(type: .custom)
    var button = SKSpriteNode()
    var bg : SKNode?
    var myParticle : SKEmitterNode?

    override func didMove(to view: SKView)
    {
        bg = SKNode(fileNamed: "bg")
        myParticle = SKEmitterNode(fileNamed: "MyParticle.sks")
        myParticle?.position = CGPoint(x: 0, y: 0)
        myParticle?.zPosition = 1
        addChild(myParticle!)
        
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) {(timer) in
            self.CreateLabel()
            self.CreateButtons()
            let fadeOut = SKAction.fadeOut(withDuration: 1)
            self.myParticle?.run(fadeOut)
        }
    }
 
    func CreateLabel()
    {

        let stageLabel = SKLabelNode(fontNamed: "MarkerFelt-Thin")
        stageLabel.position = CGPoint( x: 0, y: 450)
        stageLabel.fontSize = 48
        stageLabel.zPosition = 10
        stageLabel.text = "STAGE \(Data.currentLevel - 1) CLEARED"
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
        okButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        okButton.setTitleColor(UIColor.black, for: .normal)
        okButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
            
        okButton.addTarget(self, action: #selector(OKButton), for: .touchUpInside)
        okButton.frame = CGRect(x:  (okImage?.size.width)!/2, y: frame.height / 3.5, width: (okImage?.size.width)!, height: (okImage?.size.height)!)
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
