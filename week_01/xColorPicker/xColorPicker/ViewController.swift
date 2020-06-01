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
    var redHueCGFloat: CGFloat = 0.0
    var greenSaturationCGFloat: CGFloat = 0.0
    var blueBrightnessCGFloat: CGFloat = 0.0
    var currentSegment = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        color.layer.cornerRadius = 10
        color.clipsToBounds = true
//        redhsbLabel.layer.cornerRadius = 5
//        redhsbLabel.clipsToBounds = true
//        greensaturationLabel.layer.cornerRadius = 5
//        greensaturationLabel.clipsToBounds = true
//        bluebrightnessLabel.layer.cornerRadius = 5
//        bluebrightnessLabel.clipsToBounds = true
//        rhValueLabel.layer.cornerRadius = 10
//        rhValueLabel.clipsToBounds = true
//        gsValueLabel.layer.cornerRadius = 10
//        gsValueLabel.clipsToBounds = true
//        bbValueLabel.layer.cornerRadius = 10
//        bbValueLabel.clipsToBounds = true
        resetColorButton()
    }
    
    @IBAction func redHueSliderMoved(_ rhslider: UISlider) {
        if currentSegment == 0 {
            rhValueLabel.text = "\(sliderRoundedIntValue(rhslider))"
            redHueSlider.minimumTrackTintColor = UIColor(red: setRedColor(), green: 0, blue: 0, alpha: 1.0)
            redHueSlider.thumbTintColor = UIColor(red: setRedColor(), green: 0, blue: 0, alpha: 1.0)
        }else{
            //Need HSB
            rhValueLabel.text = "\(sliderRoundedIntValue(rhslider))"
            redHueSlider.minimumTrackTintColor = UIColor(red: setRedColor(), green: 0, blue: 0, alpha: 1.0)
        }
        setSmallBoxBackgroundColor()
    }
    
    @IBAction func greenSaturationSliderMoved(_ gsslider: UISlider) {
        if currentSegment == 0 {
            gsValueLabel.text = "\(sliderRoundedIntValue(gsslider))"
            greenSaturationSlider.minimumTrackTintColor = UIColor(red: 0, green: setGreenColor(), blue: 0, alpha: 1.0)
            greenSaturationSlider.thumbTintColor = UIColor(red: 0, green: setGreenColor(), blue: 0, alpha: 1.0)
        }else{
            //HSB
            gsValueLabel.text = "\(sliderRoundedIntValue(gsslider))"
            greenSaturationSlider.minimumTrackTintColor = UIColor(red: 0, green: setGreenColor(), blue: 0, alpha: 1.0)
        }
        setSmallBoxBackgroundColor()
    }
    
    @IBAction func blueBrightnessSliderMoved(_ bbslider: UISlider) {
        if currentSegment == 0 {
            bbValueLabel.text = "\(sliderRoundedIntValue(bbslider))"
            blueBrightnessSlider.minimumTrackTintColor = UIColor(red: 0, green: 0, blue: setBlueColor(), alpha: 1.0)
            blueBrightnessSlider.thumbTintColor = UIColor(red: 0, green: 0, blue: setBlueColor(), alpha: 1.0)
        }else{
            //HSB
            bbValueLabel.text = "\(sliderRoundedIntValue(bbslider))"
            blueBrightnessSlider.minimumTrackTintColor = UIColor(red: 0, green: 0, blue: setBlueColor(), alpha: 1.0)
        }
        setSmallBoxBackgroundColor()
    }
    
    @IBAction func resetColorButton(){
        if currentSegment == 0 {
            redHueSlider.value = 0.0
            redHueSlider.thumbTintColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
            greenSaturationSlider.value = 0.0
            greenSaturationSlider.thumbTintColor = UIColor(red: 0, green: 1.0, blue: 0, alpha: 1.0)
            blueBrightnessSlider.value = 0.0
            blueBrightnessSlider.thumbTintColor = UIColor(red: 0, green: 0, blue: 1.0, alpha: 1.0)
            color.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }else{
            //Need HSB
            redHueSlider.value = 0.0
            greenSaturationSlider.value = 0.0
            blueBrightnessSlider.value = 0.0
            color.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
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
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex
        {
        case 0:
            self.currentSegment = 0
            updateLabels()
        case 1:
            self.currentSegment = 1
            updateLabels()
        default:
            break
        }
    }
    
    func sliderRoundedIntValue(_ slider: UISlider) ->Int{
        let roundedValue = slider.value.rounded()
        return Int(roundedValue)
    }
    
    func sliderRoundedFloatValue(_ slider: UISlider) -> Float{
        let roundedValue = slider.value.rounded()
        return roundedValue
    }

    func setSmallBoxBackgroundColor(){
        color.backgroundColor = setUIColor()
    }
    func setUIColor()->UIColor{
        if currentSegment == 0 {
            return UIColor(red: setRedColor(), green: setGreenColor(), blue: setBlueColor(), alpha: 1.0)
        }else{
            //need HSBValues
            return UIColor(red: setRedColor(), green: setGreenColor(), blue: setBlueColor(), alpha: 1.0)
        }
    }
    
    func updateLabels(){
        if currentSegment == 0 {
            rhValueLabel.text = "\(redHueValue)"
            gsValueLabel.text = "\(greenSaturationValue)"
            bbValueLabel.text = "\(blueBrightnessValue)"
        }else{
            //HSB Vlaues
            rhValueLabel.text = "\(redHueValue)"
            gsValueLabel.text = "\(greenSaturationValue)"
            bbValueLabel.text = "\(blueBrightnessValue)"
        }
    }
    func setRedColor()->CGFloat{
        redHueCGFloat = CGFloat(sliderRoundedFloatValue(redHueSlider))/255.0
        return redHueCGFloat
    }
    func setGreenColor()->CGFloat{
        greenSaturationCGFloat = CGFloat(sliderRoundedFloatValue(greenSaturationSlider))/255.0
        return greenSaturationCGFloat
    }
    func setBlueColor()->CGFloat{
        blueBrightnessCGFloat = CGFloat(sliderRoundedFloatValue(blueBrightnessSlider))/255.0
        return blueBrightnessCGFloat
    }
    func setHue()->CGFloat{
        redHueCGFloat = CGFloat(sliderRoundedFloatValue(redHueSlider))/255.0
        return redHueCGFloat
    }
    func setSaturation()->CGFloat{
        greenSaturationCGFloat = CGFloat(sliderRoundedFloatValue(greenSaturationSlider))/255.0
        return greenSaturationCGFloat
    }
    func setBrightness()->CGFloat{
        blueBrightnessCGFloat = CGFloat(sliderRoundedFloatValue(blueBrightnessSlider))/255.0
        return blueBrightnessCGFloat
    }
}
