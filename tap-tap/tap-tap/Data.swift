//
//  Data.swift
//  tap-tap
//
//  Created by user162434 on 4/3/20.
//  Copyright © 2020 SpriteMedia. All rights reserved.
//

import Foundation
import SpriteKit

enum APPLE : String {
    case CIRCLE, CRESCENT, DECAGON, HEART, HEPTAGON, HEXAGON,
    NONAGON, OCTAGON, PARALLELOGRAM, PENTAGON,
    RHOMBUS, SEMICIRCLE, SQUARE, STAR, TRAPEZOID, TRIANGLE
    
    static var maxNum : Int {
        return 17
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



 
