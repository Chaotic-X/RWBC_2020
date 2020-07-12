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
    var rh: CGFloat = 0.0
    var gs: CGFloat = 0.0
    var bb: CGFloat = 0.0
    var currentSegment = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        color.layer.cornerRadius = 10
        color.clipsToBounds = true
        resetColorButton()
        updateLabels()
    }
    
    @IBAction func redHueSliderMoved(_ rhslider: UISlider) {
        if currentSegment == 0 {
            rhValueLabel.text = "\(sliderRoundedIntValue(rhslider))"
            let red = setRGB(red:sliderRoundedFloatValue(rhslider), green: 1.0, blue: 1.0)
            redHueSlider.minimumTrackTintColor = UIColor(red: red.rh, green: 1.0, blue: 1.0, alpha: 1.0)
            redHueSlider.thumbTintColor = UIColor(red: red.rh, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            //Need HSB
            rhValueLabel.text = "\(sliderRoundedIntValue(rhslider))"
            let hue = setHSB(hue: sliderRoundedFloatValue(rhslider), saturation: 1.0, brightness: 1.0)
            redHueSlider.minimumTrackTintColor = UIColor(hue: hue.h, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            redHueSlider.thumbTintColor = UIColor(hue: hue.h, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        setSmallBoxBackgroundColor()
    }
    
    @IBAction func greenSaturationSliderMoved(_ gsslider: UISlider) {
        if currentSegment == 0 {
            gsValueLabel.text = "\(sliderRoundedIntValue(gsslider))"
            let green = setRGB(red: 0, green: sliderRoundedFloatValue(greenSaturationSlider), blue: 0)
            greenSaturationSlider.minimumTrackTintColor = UIColor(red: 0, green: green.gs, blue: 0, alpha: 1.0)
            greenSaturationSlider.thumbTintColor = UIColor(red: 0, green: green.gs, blue: 0, alpha: 1.0)
        }else{
            //HSB
            gsValueLabel.text = "\(sliderRoundedIntValue(gsslider))%"
            let hsb = setHSB(hue:sliderRoundedFloatValue(gsslider), saturation: 0, brightness: 0)
            greenSaturationSlider.minimumTrackTintColor = UIColor(hue: 0, saturation: hsb.b, brightness: 0, alpha: 1.0)
            greenSaturationSlider.thumbTintColor = UIColor(hue: 0, saturation: hsb.s, brightness: 0, alpha: 1.0)
        }
        setSmallBoxBackgroundColor()
    }
    
    @IBAction func blueBrightnessSliderMoved(_ bbslider: UISlider) {
        if currentSegment == 0 {
            bbValueLabel.text = "\(sliderRoundedIntValue(bbslider))"
            let blue = setRGB(red: 0, green: 0, blue: sliderRoundedFloatValue(blueBrightnessSlider))
            blueBrightnessSlider.minimumTrackTintColor = UIColor(red: 0, green: 0, blue: blue.bb, alpha: 1.0)
            blueBrightnessSlider.thumbTintColor = UIColor(red: 0, green: 0, blue: blue.bb, alpha: 1.0)
        }else{
            //HSB
            bbValueLabel.text = "\(sliderRoundedIntValue(bbslider))%"
            let hsb = setHSB(hue:sliderRoundedFloatValue(bbslider), saturation: 0, brightness: 0)
            blueBrightnessSlider.minimumTrackTintColor = UIColor(hue: 0, saturation: 0, brightness: hsb.b, alpha: 1.0)
            blueBrightnessSlider.thumbTintColor = UIColor(hue: 0, saturation: 0, brightness: hsb.b, alpha: 1.0)
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
            redHueSlider.value = 0.5
            redHueSlider.thumbTintColor = UIColor(hue: 0.5, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            redHueSlider.minimumTrackTintColor = UIColor(hue: 0.5, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            greenSaturationSlider.value = 1.0
            greenSaturationSlider.thumbTintColor = UIColor(hue: 0.5, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            greenSaturationSlider.minimumTrackTintColor = UIColor(hue: 0.5, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            blueBrightnessSlider.value = 1.0
            blueBrightnessSlider.thumbTintColor = UIColor(hue: 0.5, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            blueBrightnessSlider.minimumTrackTintColor = UIColor(hue: 0.5, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            color.backgroundColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 1.0)
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
            if let colorName = alertController.textFields?.first?.text {
                self.colorNameLabel.text = colorName
                self.view.backgroundColor = self.setUIColor()
            }
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
            redHueSlider.maximumValue = 255
            greenSaturationSlider.maximumValue = 255
            blueBrightnessSlider.maximumValue = 255
        case 1:
            self.currentSegment = 1
            updateLabels()
            redHueSlider.maximumValue = 360
            greenSaturationSlider.maximumValue = 100
            blueBrightnessSlider.maximumValue = 100
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
            let rgb = setRGB(red: sliderRoundedFloatValue(redHueSlider), green: sliderRoundedFloatValue(greenSaturationSlider), blue: sliderRoundedFloatValue(blueBrightnessSlider))
            return UIColor(red: rgb.rh, green: rgb.gs, blue: rgb.bb, alpha: 1.0)
        }else{
            //need HSBValues
            let hsb = setHSB(hue: sliderRoundedFloatValue(redHueSlider), saturation: sliderRoundedFloatValue(greenSaturationSlider), brightness: sliderRoundedFloatValue(blueBrightnessSlider))
            return UIColor(hue: hsb.h, saturation: hsb.s, brightness: hsb.b, alpha: 1.0)
        }
    }
    
    func updateLabels(){
        if currentSegment == 0 {
            redhsbLabel.text = "R"
            greensaturationLabel.text = "G"
            rhValueLabel.text = "\(redHueValue)"
            gsValueLabel.text = "\(greenSaturationValue)"
            bbValueLabel.text = "\(blueBrightnessValue)"
        }else{
            //HSB Vlaues
            redhsbLabel.text = "H"
            greensaturationLabel.text = "S"
            rhValueLabel.text = "\(redHueValue)"
            gsValueLabel.text = "\(greenSaturationValue)%"
            bbValueLabel.text = "\(blueBrightnessValue)%"
        }
    }
    
    func setRGB (red: Float, green: Float, blue: Float) -> (rh: CGFloat, gs: CGFloat, bb: CGFloat){
        rh = CGFloat(sliderRoundedFloatValue(redHueSlider))
        gs = CGFloat(sliderRoundedFloatValue(greenSaturationSlider))
        bb = CGFloat(sliderRoundedFloatValue(blueBrightnessSlider))
        return (rh: rh/255.0, gs: gs/255.0, bb: bb/255.0)
    }
    func setHSB (hue: Float, saturation: Float, brightness: Float) -> (h: CGFloat, s: CGFloat, b: CGFloat){
        rh = CGFloat(sliderRoundedFloatValue(redHueSlider))
        gs = CGFloat(sliderRoundedFloatValue(greenSaturationSlider))
        bb = CGFloat(sliderRoundedFloatValue(blueBrightnessSlider))
        return (h: rh/360.0, s: gs/100, b: bb/100)
    }
    func rgbToHSB(hue: Float, saturation: Float, brightness: Float) -> (h: CGFloat, s: CGFloat, b: CGFloat){
        rh = CGFloat(sliderRoundedFloatValue(redHueSlider))
        gs = CGFloat(sliderRoundedFloatValue(greenSaturationSlider))
        bb = CGFloat(sliderRoundedFloatValue(blueBrightnessSlider))
        let minV:CGFloat = CGFloat(min(rh, gs, bb))
        let maxV:CGFloat = CGFloat(max(rh, gs, bb))
        let delta:CGFloat = maxV - minV
        var hue:CGFloat = 0
        if delta != 0 {
            if rh == maxV {
                hue = (gs - bb) / delta
            }
            else if gs == maxV {
                hue = 2 + (bb - rh) / delta
            }
            else {
                hue = 4 + (rh - gs) / delta
            }
            hue *= 60
            if hue < 0 {
                hue += 360
            }
        }
        let saturation = maxV == 0 ? 0 : (delta / maxV)
        let brightness = maxV
        return (h:hue/360, s:saturation, b:brightness)
    }
}
