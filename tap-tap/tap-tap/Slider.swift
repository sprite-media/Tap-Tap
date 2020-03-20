//
//  Slider.swift
//  tap-tap
//
//  Created by SpriteMedia on 3/19/20.
//  Copyright © 2020 SpriteMedia. All rights reserved.
//

import SpriteKit

class Slider
{
    private var visible : Bool = false
    private var parent : SKScene?
    private var bg : SKSpriteNode = SKSpriteNode()
    private var handle : SKSpriteNode = SKSpriteNode()
    
    private var _value : CGFloat = 0
    private var _position : CGPoint = CGPoint(x:0, y:0)
    private var _size : CGSize = CGSize(width: 0, height: 0)
    private var _zPosition : CGFloat = 0
    
    var value : CGFloat
    {
        get{return self._value}
        set
        {
            self._value = newValue
            //change handle position
            handle.position = CGPoint(x: PointFromValue(val: self._value).x, y: bg.position.y)
        }
    }
    var position : CGPoint
    {
        get{return self._position}
        set
        {
            self._position = newValue
            bg.position = self._position
            let val = self._value
            self._value = val
        }
    }
    var size : CGSize
    {
        get{return self._size}
        set
        {
            self._size = newValue
            //change sprite size
            bg.scale(to: self._size)
            handle.scale(to: CGSize(width:bg.size.width * 0.12, height: bg.size.height))
            //set position again with new size
            let val = self._value
            self._value = val
        }
    }
    var zPosition : CGFloat
    {
        get{return self._zPosition}
        set
        {
            self._zPosition = newValue
            bg.zPosition = self._zPosition
            handle.zPosition = self._zPosition+1
        }
    }
    init(_parent : SKScene)
    {
        parent = _parent
        bg = SKSpriteNode(texture: SKTexture(imageNamed: "SliderBGFrame"))
        handle = SKSpriteNode(texture : SKTexture(imageNamed: "SliderBox"))
    }
    
    func AddToScene()
    {
        parent!.addChild(bg)
        parent!.addChild(handle)
        visible = true
    }
    func RemoveFromParent()
    {
        bg.removeFromParent()
        handle.removeFromParent()
        visible = false
    }
    func ValueChange(touchPoint : CGPoint, function : (_ vol:Float)->Void)
    {
        if(visible && bg.contains(touchPoint))
        {
            value = ValueFromPoint(point: touchPoint)
            //receive function as parameter
            function(Float(value))
        }
    }
    func ValueFromPoint(point : CGPoint) -> CGFloat
    {
        return (point.x - _position.x + (_size.width*0.5)) / (_size.width * 0.5)
    }
    func PointFromValue(val : CGFloat) -> CGPoint
    {
        return CGPoint(x : _position.x + (_value * (_size.width * 0.5)) - _size.width * 0.5, y : _position.y)
    }
}
