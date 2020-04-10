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

    var bgm = AVAudioPlayer()
    var sfx = AVAudioPlayer()
    
    func StartBackgroundMusic(soundName : String) {
        do
        {
            bgm = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!))
            bgm.prepareToPlay()
            bgm.numberOfLoops = -1
            bgm.play()
        }
        catch
        {
            print(error)
        }
    }
    
    func PlaySfx(soundName: String)
    {
        do
        {
            sfx = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!))
            sfx.prepareToPlay()
            sfx.numberOfLoops = 1
            sfx.play()
        }
        catch
        {
            print(error)
        }
    }
    
}


 
