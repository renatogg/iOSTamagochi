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
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
}