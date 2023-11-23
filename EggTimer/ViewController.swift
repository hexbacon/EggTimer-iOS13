//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    let eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    var timer = Timer();
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    // Outlets
    @IBOutlet weak var eggLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    //Actions & Functions
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        // Set & Reset progress bar
        progressBar.progress = 0.0
        eggLabel.text = hardness
        secondsPassed = 0
    }
    // Update progress bar
    @objc func updateCounter() {
        if(secondsPassed < totalTime  ) {
            secondsPassed += 1
            let percentage = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentage
        } else {
            timer.invalidate()
            eggLabel.text = "Done"
            playSound()
        }
    }
    func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
                    
        }
}
