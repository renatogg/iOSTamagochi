//
//  ViewController.swift
//  Tamagochi
//
//  Created by Renato Gasoto on 5/9/16.
//  Copyright © 2016 Renato Gasoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: UIImageView!
    @IBOutlet weak var heartImg: UIImageView!
    @IBOutlet weak var foodImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imgArray = [UIImage]()
        for i in 1..<5 {
            let img = UIImage(named: "idle\(i).png")
            imgArray.append(img!)
        }
        
        monsterImg.animationImages = imgArray
        monsterImg.animationDuration = 0.8
        monsterImg.animationRepeatCount = 0
        monsterImg.startAnimating()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}
