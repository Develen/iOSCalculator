//
//  LogicOfCalculation.swift
//  Calculator
//
//  Created by Admin on 20.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

class LogicOfCalulation {
     class func calculateResult (firstNumber: Double, secondNumber: String, arithmeticCommand: CalculationCommand) -> Double {
        switch arithmeticCommand {
        case .addition:
            return firstNumber + (secondNumber as NSString).doubleValue
        case .subtraction:
            return firstNumber - (secondNumber as NSString).doubleValue
        case .multiplication:
            return firstNumber * (secondNumber as NSString).doubleValue
        case .division:
            if secondNumber == "0" {
                return 0
            } else {
            return firstNumber  / (secondNumber as NSString).doubleValue
            }
        default:
            return 0
        }
    }
    init() {
        
    }
    
}



