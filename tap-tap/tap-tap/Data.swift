//
//  Data.swift
//  tap-tap
//
//  Created by user162434 on 4/3/20.
//  Copyright © 2020 SpriteMedia. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

enum APPLE : String {
    case CIRCLE, CRESCENT, DECAGON, HEART, HEPTAGON, HEXAGON,
    NONAGON, OCTAGON, PARALLELOGRAM, PENTAGON,
    RHOMBUS, SEMICIRCLE, SQUARE, STAR, TRAPEZOID, TRIANGLE
    
    static var maxNum : Int {
        return 16
    }
}

struct Data {
    static var currentLevel : UInt32 = 1
    static var didWin : Bool = false
    static let apple = [
        "CIRCLE", "CRESCENT", "DECAGON", "HEART", "HEPTAGON", "HEXAGON",
        "NONAGON", "OCTAGON", "PARALLELOGRAM", "PENTAGON",
        "RHOMBUS", "SEMICIRCLE", "SQUARE", "STAR", "TRAPEZOID", "TRIANGLE"
    ]
    
}

class SoundManager {
    static var shared = SoundManager()
    var bgm : SKAudioNode = SKAudioNode()
    
    func StartBackgroundMusic(soundName : String) {
        let sound : SKAction = SKAction.playSoundFileNamed(soundName, waitForCompletion: false)
        let loopSound : SKAction = SKAction.repeatForever(sound)
        bgm.run(loopSound)
    }
    
    func StopBackgroundMusic() {

    }
    
}


 
