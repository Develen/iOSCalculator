//
//  LogicOfCalculation.swift
//  Calculator
//
//  Created by Admin on 20.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

public class LogicOfCalulation {
     public class func calculateResult (firstNumber: Double, secondNumber: Double, arithmeticCommand: CalculationCommand) -> Double {
        switch arithmeticCommand {
        case .addition:
            return firstNumber + secondNumber
        case .subtraction:
            return firstNumber - secondNumber
        case .multiplication:
            return firstNumber * secondNumber
        case .division:
            if secondNumber == 0 || secondNumber == 0.0  {
                return 0
            } else {
            return firstNumber  / secondNumber
            }
        default:
            return 0
        }
    }
    init() {
        
    }
    
}



