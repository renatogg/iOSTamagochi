//
//  ViewController.swift
//  Tamagochi
//
//  Created by Renato Gasoto on 5/9/16.
//  Copyright © 2016 Renato Gasoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var foodImg: DragImg!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
    }
    
    func itemDroppedOnCharacter(notif: AnyObject){
        print( "Hello World!")
    }
   

}

