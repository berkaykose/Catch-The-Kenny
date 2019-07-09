//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Berkay Köse on 24.06.2019.
//  Copyright © 2019 Berkay Köse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Variables
    var timer = Timer()
    var timer2 = Timer()
    var totalTime = 30
    var isKennyHere = 0
    var score = 0
    var firstHighScore = 0
    var kennyArray = [UIImageView]()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        
        if let newScore = highScore as? Int {
            highScoreLabel.text = "High Score: \(newScore)"
        }
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.catchingKenny))
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.catchingKenny))
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.catchingKenny))
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.catchingKenny))
        let gesture5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.catchingKenny))
        let gesture6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.catchingKenny))
        let gesture7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.catchingKenny))
        let gesture8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.catchingKenny))
        let gesture9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.catchingKenny))
        
        image1.addGestureRecognizer(gesture1)
        image2.addGestureRecognizer(gesture2)
        image3.addGestureRecognizer(gesture3)
        image4.addGestureRecognizer(gesture4)
        image5.addGestureRecognizer(gesture5)
        image6.addGestureRecognizer(gesture6)
        image7.addGestureRecognizer(gesture7)
        image8.addGestureRecognizer(gesture8)
        image9.addGestureRecognizer(gesture9)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeRemaining), userInfo: nil, repeats: true)
        
        timer2 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        kennyArray.append(image1)
        kennyArray.append(image2)
        kennyArray.append(image3)
        kennyArray.append(image4)
        kennyArray.append(image5)
        kennyArray.append(image6)
        kennyArray.append(image7)
        kennyArray.append(image8)
        kennyArray.append(image9)
        
        hideKenny()
    }
    
    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(kennyArray.count) - 1))
        kennyArray[randomNumber].isHidden = false
    }
    
    @objc func catchingKenny() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func timeRemaining() {
        totalTime -= 1
        timeLabel.text = "\(totalTime)"
       
        if totalTime == 0 {
            timeLabel.isHidden = true
            timer2.invalidate()
            
            if self.score > self.firstHighScore {
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highScoreLabel.text = "High Score: \(self.score)"
            }
            
            let alert = UIAlertController(title: "Oyun Bitti", message: "", preferredStyle: .alert)
            let playAgain = UIAlertAction(title: "Play Again", style: .default) { (playAgain) in
                self.playTheGameAgain()
            }
            let stopPlaying = UIAlertAction(title: "Stop Playing", style: .destructive) { (action) in
                self.timer.invalidate()
            }
            
            alert.addAction(playAgain)
            alert.addAction(stopPlaying)
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    func playTheGameAgain() {
        score = 0
        scoreLabel.text = "Score: \(score)"
        totalTime = 30
        timeLabel.text = "\(totalTime)"
        timeLabel.isHidden = false
        timer2 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }
}

