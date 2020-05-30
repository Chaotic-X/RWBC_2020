//
//  ViewController.swift
//  xColorPicker
//
//  Created by Alex Lundquist on 5/28/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var redhsbLabel: UILabel!
    @IBOutlet weak var greensaturationLabel: UILabel!
    @IBOutlet weak var bluebrightnessLabel: UILabel!
    @IBOutlet weak var rhValueLabel: UILabel!
    @IBOutlet weak var gsValueLabel: UILabel!
    @IBOutlet weak var bbValueLabel: UILabel!
    @IBOutlet weak var redHueSlider: UISlider!
    @IBOutlet weak var greenSaturationSlider: UISlider!
    @IBOutlet weak var blueBrightnessSlider: UISlider!
    
    var textField = UITextField()
    var redHueValue = 0
    var greenSaturationValue = 0
    var blueBrightnessValue = 0
    var redCGFloat: CGFloat = 0.0
    var greenCGFloat: CGFloat = 0.0
    var blueCGFloat: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        color.layer.cornerRadius = 10
        color.clipsToBounds = true
        resetColorButton()
    }

    @IBAction func redHueSliderMoved(_ rhslider: UISlider) {
        rhValueLabel.text = "\(sliderRoundedIntValue(rhslider))"
        redHueSlider.minimumTrackTintColor = UIColor(red: setRedColor(), green: 0, blue: 0, alpha: 1.0)
        setSmallBoxBackgroundColor()
        
    }
    
    @IBAction func greenSaturationSliderMoved(_ gsslider: UISlider) {
        gsValueLabel.text = "\(sliderRoundedIntValue(gsslider))"
        greenSaturationSlider.minimumTrackTintColor = UIColor(red: 0, green: setGreenColor(), blue: 0, alpha: 1.0)
        setSmallBoxBackgroundColor()
    }
    
    @IBAction func blueBrightnessSliderMoved(_ bbslider: UISlider) {
        bbValueLabel.text = "\(sliderRoundedIntValue(bbslider))"
        blueBrightnessSlider.minimumTrackTintColor = UIColor(red: 0, green: 0, blue: setBlueColor(), alpha: 1.0)
        setSmallBoxBackgroundColor()
    }
    
    @IBAction func resetColorButton(){
        redHueSlider.value = 0.0
        greenSaturationSlider.value = 0.0
        blueBrightnessSlider.value = 0.0
        color.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        view.backgroundColor = UIColor.white
        colorNameLabel.text = "Custom Color Name"
        updateLabels()
    }
    
    @IBAction func setColorNameButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Custom Color Name", message: "Type a name for your color", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Name it anything"
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let nameAction = UIAlertAction(title: "Name IT!", style: .default) { (_) in
            let colorName = alertController.textFields?.first?.text
            self.colorNameLabel.text = colorName
//            self.color.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            self.view.backgroundColor = self.setUIColor()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(nameAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func sliderRoundedIntValue(_ slider: UISlider) ->Int{
        let roundedValue = slider.value.rounded()
        return Int(roundedValue)
    }
    
    func sliderRoundedFloatValue(_ slider: UISlider) -> Float{
        let roundedValue = slider.value.rounded()
        return roundedValue
    }
    func setRedColor()->CGFloat{
        redCGFloat = CGFloat(sliderRoundedFloatValue(redHueSlider))/255.0
        return redCGFloat
    }
    func setGreenColor()->CGFloat{
        greenCGFloat = CGFloat(sliderRoundedFloatValue(greenSaturationSlider))/255.0
        return greenCGFloat
    }
    func setBlueColor()->CGFloat{
        blueCGFloat = CGFloat(sliderRoundedFloatValue(blueBrightnessSlider))/255.0
        return blueCGFloat
    }
    func setSmallBoxBackgroundColor(){
        color.backgroundColor = setUIColor()
    }
    func setUIColor()->UIColor{
        return UIColor(red: setRedColor(), green: setGreenColor(), blue: setBlueColor(), alpha: 1.0)
    }
    
    func updateLabels(){
        rhValueLabel.text = "\(redHueValue)"
        gsValueLabel.text = "\(greenSaturationValue)"
        bbValueLabel.text = "\(blueBrightnessValue)"
    }
}
