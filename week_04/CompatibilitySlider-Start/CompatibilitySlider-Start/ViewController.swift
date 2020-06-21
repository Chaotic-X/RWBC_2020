//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var compatibilityItemLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var questionLabel: UILabel!
  
//    var compatibilityItems = ["Cats", "Dogs"] // Add more!
  var compatibilityItems = ["Cats", "Dogs", "Chocolate", "Vanilla", "Kirk", "Picard"]
  var currentItemIndex = 0
  var person1 = Person(id: 1, items: [:])
  var person2 = Person(id: 2, items: [:])
//  let sliderValue: Double
  var currentItem = ""
  var turnCount = 1
  var currentPerson: Person?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateDateUI()
  }
  
  @IBAction func sliderValueChanged(_ sender: UISlider) {
  }
  
  @IBAction func didPressNextItemButton(_ sender: Any) {
    currentItem = compatibilityItems[currentItemIndex]

    if turnCount == 1 {
      person1.items.updateValue(slider.value, forKey: currentItem)
    }else{
      person2.items.updateValue(slider.value, forKey: currentItem)
    }
    slider.value = 0.5
    roundCount()
    updateDateUI()
  }
  func updateDateUI(){
    currentItem = compatibilityItems[currentItemIndex]
    personNumber()
  }
  func roundCount(){
    if currentItemIndex < compatibilityItems.count - 1 {
      currentItemIndex += 1
    }else{
      currentItemIndex = 0
      turnCount += 1
    }
  }
  func personNumber(){
    switch turnCount{
      case 1:
        questionLabel.text = "Person 1, how do you feel about..."
        compatibilityItemLabel.text =  currentItem
      case 2:
        questionLabel.text = "Person 2, how do you feel about..."
        compatibilityItemLabel.text =  currentItem
      default:
        compatibilityAlert()
        print("Game Over")
    }
  }
  func calculateCompatibility() -> String {
    // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
    var percentagesForAllItems: [Double] = []
    print(person1.items)
    print(person2.items)
    for (key, person1Rating) in person1.items {
      let person2Rating = person2.items[key] ?? 0
      print("\(person1Rating) ++ \(person2Rating)")
      let difference = abs(person1Rating - person2Rating)/5.0
      print("This is the difference: \(difference)")
      percentagesForAllItems.append(Double(difference))
    }
    print("This is the Percentage for All Items: \(percentagesForAllItems)")
    let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
    print("This is the Sum of all Percentages: \(sumOfAllPercentages)")
    let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
    print(matchPercentage, "%")
    let matchString = 100 - (matchPercentage * 100).rounded()
    print("\(matchString)%")
    return "\(matchString)%"
  }
  func resetGame(){
    person1.items.removeAll()
    person2.items.removeAll()
    turnCount = 1
    currentItemIndex = 0
    updateDateUI()
    
  }
  func compatibilityAlert(){
    let message = "You two are \(calculateCompatibility()) compatible"
    let alert = UIAlertController(title: "Compatibility Results", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "oK", style: .default, handler: {action in
      self.resetGame()
        })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
}

