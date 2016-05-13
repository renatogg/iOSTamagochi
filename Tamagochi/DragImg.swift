//
//  DragImg.swift
//  Tamagochi
//
//  Created by Renato Gasoto on 5/12/16.
//  Copyright © 2016 Renato Gasoto. All rights reserved.
//

import Foundation
import UIKit

class DragImg: UIImageView{
    
    var originalPosition: CGPoint!
    var dropTarget: UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first, let target = dropTarget{
            let position = touch.locationInView(target.superview)
//            print (position)
            if CGRectContainsPoint(target.frame, position){
                let point = touch.locationInView(target)
                if (alphaFromPoint(point,target: target)) == 1.0{
                //Submit notification that target was dropped correctly
                    NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
                }
            }

        }
        
        
        self.center = originalPosition
    }
    
    func alphaFromPoint(point: CGPoint,target: UIImageView) -> CGFloat {
            var pixel: [UInt8] = [0, 0, 0, 1]
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let alphaInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
            let context = CGBitmapContextCreate(UnsafeMutablePointer(pixel), 1, 1, 8, 4, colorSpace, alphaInfo.rawValue)!
    
            CGContextTranslateCTM(context, -point.x, -point.y);
    
            target.layer.renderInContext(context)
            print(pixel)
            let floatAlpha = CGFloat(pixel[3])/255

        
        
            return floatAlpha
    }
}