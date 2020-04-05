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
    case CIRCLE, CRESENT, DECAGON, HEART, HEPTAGON, HEXAGON,
    NONAGON, OCTAGON, OVAL, PARALLELOGRAM, PENTAGON,
    RECTANGLE, RHOMBUS, SEMICICLE, SQUARE, STAR, TRAPEZOID, TRIANGLE
    
    static var maxNum : UInt32 {
        return 18
    }
}

struct Data {
    static var currentLevel : UInt32 = 0
}
