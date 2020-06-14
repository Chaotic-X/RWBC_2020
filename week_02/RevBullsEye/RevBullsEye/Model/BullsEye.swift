//
//  BullsEye.swift
//  BullsEye
//
//  Created by Alex Lundquist on 6/12/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation

class BullsEye{
    var currentValue : Int = 0
    var guessValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    var title: String = ""
    var message: String = ""
    var guessText: String = ""
    
    func differenceAlert(thisTarget: Int, thisCurrent: Int){
//        var score = curretScore
        let difference = abs(thisTarget - thisCurrent)
        var points = 100 - difference
        score += points
        if difference == 0 {
            title = "Must have been divine intervention!🧞‍♂️"
            message = "You scored a perfect \(points)\nYou get an extra 💯 POINTS!"
            points += 100
//            return [title,message]
        }else if difference == 1 {
            title = "Good, but no divine intervention"
            message = "You were 1 off! 🤦🏽\nBounus 50 POINTS!"
            points += 50
//            return [title,message]
        }else if difference < 5 {
            title = "You missed it by\n\"This ✋🏼 🤚🏼 MUCH\""
            message = "You scored \(points)"
//            return [title,message]
        }else if difference < 10 {
            title = "Almost, but not good enough!"
            message = "You scored \(points) 🤷🏼‍♂️"
//            return [title,message]
        } else if difference < 15 {
            title = "Losing is like... well...\n...For losers like you!"
            message = "☠️☠️☠️You scored \(points)☠️☠️☠️\nBut I should have docked you points"
//            return [title,message]
        }else{
            title = "🤬🤬🤬\nJust delete the app now...\n🤬🤬🤬"
            message = "You really want to know?\nFine your scored a horrible \(points)"
//            return [title,message]
        }
        
    }//End of differenceAlert
    func convertToInt(forString: String)->Int{
        if let convertThis = NumberFormatter().number(from: forString) {
            let newInt: Int = convertThis.intValue
            if newInt > 1 && newInt < 100 {
            return newInt
            }else{
                return 0
            }
        }
        return 0
    }
    func newRound(){
        round += 1
        currentValue = Int.random(in: 1...100)
        guessValue = 0
    }
}//End Class
