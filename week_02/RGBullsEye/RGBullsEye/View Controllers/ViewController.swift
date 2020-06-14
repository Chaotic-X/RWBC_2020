/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //Source of Truth for both Game and RGB
    let game = Game()
    var rgb = RGB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateView()
    }
    
    //MARK: - IBActions Functions
    //MARK: -- Slider
    @IBAction func aSliderMoved(_ sender: UISlider) {
        //Switch off of which slider is sending values
        //Grab those values and convert to Int and place value in corresponding label
        switch sender {
        case redSlider:
            rgb.r = Int(sender.value)
            redLabel.text = "R: \(rgb.r)"
        case greenSlider:
            rgb.g = Int(sender.value)
            greenLabel.text = "G: \(rgb.g)"
        case blueSlider:
            rgb.b = Int(sender.value)
            blueLabel.text = "B: \(rgb.b)"
        default:
            break
        }
        //Change backgound color based on values from sliders
        guessLabel.backgroundColor = UIColor(rgbStruct: rgb)
    }
    
    //MARK: - "Hit Me Button" AlertController
    @IBAction func showAlert(_ sender: UIButton) {
        //Update Target Label Text with the random Target values the round/Game started with
        targetTextLabel.text = """
        R: \(game.targetValue.r) \
        G: \(game.targetValue.g) \
        B: \(game.targetValue.b)
        """
        //Check if they got the match, if they didn't get the difference.
        let difference = game.hitMeCheck(guessValue: rgb)
        //Set default Title value
        var title = "You suck at this don't you?"
        //Logic to check if they hit the Mark, or missed it by the difference.
        if difference == 0 {
            title = "Congrats! Your not ColorBlind!"
        }else if difference < 5 {
            title = "You see better then the average Dog"
        }else if difference < 10 {
            title = "Either you ARE colorblind? \nor\nYou need to schedule an eye appointment"
        }
        //Message displaying what they scored that round
        let message = "Your scored \(game.score) points!"
        //Set the Title and message in the AlertController and setting its style to alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //The Action when the user click's the "ok" and setting its style to default
        //and then stating what actions it needs to take once that button has been hit
        let action = UIAlertAction(title: "oK", style: .default, handler: {action in
            self.game.newRound()
            self.updateView()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK: - StartOver/Reset
    @IBAction func startOver() {
        //call newRound from Game Class
        game.newRound()
        //Update the view
        updateView()
    }
    //MARK: - Supplemental/Helper functions
    //MARK: -- UpdateView
    func updateView() {
        //set target Background Color to its current random RGB Values
        targetLabel.backgroundColor = UIColor(rgbStruct: game.targetValue)
        //set Text to "Start of Round/New Game Text"
        targetTextLabel.text = "Can you match this Color?"
        //initialise RGB to the current RGB Values
        rgb = game.currentValue
        //Set the Guess background color to the initialized values
        guessLabel.backgroundColor = UIColor(rgbStruct: rgb)
        //Update the R: G: B: text with the sliders current values"
        redLabel.text = "R: \(rgb.r)"
        greenLabel.text = "G: \(rgb.g)"
        blueLabel.text = "B: \(rgb.b)"
        
        //update the slider values with what is instantiated RGB updated values
        redSlider.value = Float(rgb.r)
        greenSlider.value = Float(rgb.g)
        blueSlider.value = Float(rgb.b)
        
        //Update the Round # and Score value
        roundLabel.text = "Round: \(game.round)"
        scoreLabel.text = "Score: \(game.total)"
    }
    
}

