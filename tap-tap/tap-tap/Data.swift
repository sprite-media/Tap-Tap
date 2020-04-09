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
    static let shared = SoundManager()
    var audioPlayer: AVAudioPlayer?
    
    func StartBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "audio/bensound-littleidea", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else {return}
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func StopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
    
}


 
