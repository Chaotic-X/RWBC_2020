//
//  ViewController.swift
//  BullsEye
//
//  Created by Alex Lundquist on 5/26/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var game = BullsEye()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        game.currentValue = Int(roundedValue)
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    @IBAction func showAlert() {
        game.differenceAlert(thisTarget: game.targetValue, thisCurrent: game.currentValue)
        let alert = UIAlertController(title: game.title,
                                      message: game.message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: {
                                    action in
                                    self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true,
                completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        game.currentValue = Int(roundedValue)
    }
    
    @IBAction func startNewGame() {
        game.score = 0
        game.round = 0
        startNewRound()
    }
    func startNewRound() {
        //new round
        game.newRound()
        slider.value = Float(game.currentValue)
        updateLabels()
    }
    func updateLabels() {
        targetLabel.text = "\(game.targetValue)"
        scoreLabel.text = "\(game.score)"
        roundLabel.text = "\(game.round)"
    }
}

