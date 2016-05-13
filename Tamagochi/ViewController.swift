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
    @IBOutlet var lifes: Array<UIView>!
    
    let DIM_ALPHA: CGFloat = 0.2 //Opacity of disabled items / Lost Lifes
    let OPAQUE: CGFloat = 1.0
    
    var penalties = 0
    var timer: NSTimer!
    override func viewDidLoad() {
        super.viewDidLoad()
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        for life in lifes{
            life.alpha = DIM_ALPHA
        }
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        startTimer()

    }
    
    func itemDroppedOnCharacter(notif: AnyObject){
        print( "Hello World!")
    }
   
    func startTimer(){
        if timer != nil{
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState(){
        if penalties < lifes.endIndex{
            penalties += 1
        }
        for i in 0..<penalties{
            lifes[i].alpha = OPAQUE
        }
        for i in penalties..<lifes.endIndex{
            lifes[i].alpha = DIM_ALPHA
        }
        if penalties == lifes.endIndex{
            gameOver()
        }
        
    }
    func gameOver(){
        timer.invalidate()
        monsterImg.playAnimation(true)
    }

}

