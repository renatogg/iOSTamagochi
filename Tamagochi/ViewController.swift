//
//  ViewController.swift
//  Tamagochi
//
//  Created by Renato Gasoto on 5/9/16.
//  Copyright © 2016 Renato Gasoto. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet var lifes: Array<UIView>!
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    
    let DIM_ALPHA: CGFloat = 0.2 //Opacity of disabled items / Lost Lifes
    let OPAQUE: CGFloat = 1.0
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = true
    var currentItem: UInt32 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        loadAudios()
        for life in lifes{
            life.alpha = DIM_ALPHA
        }
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        startTimer()

    }
    func loadAudios(){
        do{
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            sfxSkull.prepareToPlay()
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            musicPlayer.play()
        }catch let err as NSError{
            print (err.debugDescription)
        }
    }
    
    func itemDroppedOnCharacter(notif: AnyObject){
        monsterHappy = true
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        startTimer()
        
        if currentItem == 0{
            sfxHeart.play()
        }else{
            sfxBite.play()
        }
    }
   
    func startTimer(){
        if timer != nil{
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState(){
        if !monsterHappy
        {
                penalties += 1
                sfxSkull.play()
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
        if penalties < lifes.endIndex {
            let rand = arc4random_uniform(2)
            if rand == 0{
                foodImg.alpha = DIM_ALPHA
                foodImg.userInteractionEnabled = false
                
                heartImg.alpha = OPAQUE
                heartImg.userInteractionEnabled = true
                
            }
            else{
                foodImg.alpha = OPAQUE
                foodImg.userInteractionEnabled = true
                
                heartImg.alpha = DIM_ALPHA
                heartImg.userInteractionEnabled = false
            }
            currentItem = rand
            monsterHappy = false
        }
    }
    
    func gameOver(){
        timer.invalidate()
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        monsterImg.playAnimation(true)
        sfxDeath.play()
        musicPlayer.stop()
    }

}

