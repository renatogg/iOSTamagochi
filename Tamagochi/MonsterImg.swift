//
//  MonsterImg.swift
//  Tamagochi
//
//  Created by Renato Gasoto on 5/12/16.
//  Copyright © 2016 Renato Gasoto. All rights reserved.
//

import Foundation
import UIKit

extension Array{
    var last: Element{
        return self[self.endIndex - 1]
    }
}

class MonsterImg : UIImageView{
    override init(frame: CGRect){
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder :NSCoder){
        super.init(coder: aDecoder)
        playAnimation(false)
    }
    
    func playAnimation(dead: Bool){
        var imgArray = [UIImage]()
        self.animationImages = nil
        if !dead{
            for i in 1..<5 {
                let img = UIImage(named: "idle\(i).png")
                imgArray.append(img!)
            }
        }else{
            for i in 1..<6 {
                let img = UIImage(named: "dead\(i).png")
                imgArray.append(img!)
            }
        }
        self.image = imgArray.last
        self.animationImages = imgArray
        self.animationDuration = 0.8
        print (Int(dead))
        self.animationRepeatCount = Int(dead)
        self.startAnimating()

    }
}