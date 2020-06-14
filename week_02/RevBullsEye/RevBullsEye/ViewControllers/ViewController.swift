//
//  ViewController.swift
//  BullsEye
//
//  Created by Alex Lundquist on 5/26/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var game = BullsEye()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        game.currentValue = Int(roundedValue)
        guessTextField.delegate = self
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
        let numberInput = game.convertToInt(forString: guessTextField.text ?? "")
        print("This is my Converted number: \(numberInput)")
        if numberInput == 0 {
            let alert = UIAlertController(title: "Bad Guess!", message: "Please enter a number between 1-100", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        
        }else{
        game.differenceAlert(thisTarget: numberInput, thisCurrent: game.currentValue)
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
        guessTextField.text = game.guessText
        slider.value = Float(game.currentValue)
        updateLabels()
    }
    func updateLabels() {
        
        scoreLabel.text = "\(game.score)"
        roundLabel.text = "\(game.round)"
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // remove non-numerics and compare with original string
        return string == string.filter("0123456789".contains)
    }
}

