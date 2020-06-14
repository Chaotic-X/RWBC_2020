//
//  Game.swift
//  RGBullsEye
//
//  Created by Alex Lundquist on 6/13/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

class Game {
    //class items
    var round = 0
    let currentValue = RGB()
    var targetValue = RGB()
    var score = 0
    var total = 0
    
    //This always us to initialize our class items in the ViewDidLoad of our ViewCrontroller.
    init(){
        gameStart()
    }
    
    //how we start the game by have set initial values. Also calls for a new round.
    func gameStart(){
        round = 0
        total = 0
        newRound()
    }
    
    //Starts a new round by incrementing the round count from 0 -> 1 and ressting the score to 0
    func newRound(){
        round = +1
        score = 0
        targetValue = .random()
    }
    
    //How to score the round based on the difference the user got when the "Hit me!" button is tapped.
    func hitMeCheck(guessValue: RGB) -> Int{
        //Calling the difference function from the RGB Struct to check the guess on the target values, get that back as a doubel and convert it an Int for its scoring portion
        let difference = Int((guessValue.difference(target: targetValue) * 100.0).rounded())
        //Set the points scored for the round
        score = 100 - difference
        //If the user got 100% add 100 points to score
        if difference == 0 {
            score += 100
        //If the user was off by 1 or 99% add 50 points to the score
        }else if difference == 1 {
            score += 50
        }
        //increase the Total by the score total
        total += score
        return difference
    }
    
    
}
