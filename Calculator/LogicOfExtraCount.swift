//
//  LogicOfExtraCount.swift
//  Calculator
//
//  Created by Admin on 11.10.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

public class LogicOfExtraCount {
    
    public static func countingExtraOperation (number: Double, extraOperation: ExtraOperation) -> Double {
        switch extraOperation {
        case .percent:
            return number / 100
        case .root:
            if number == 0 {
                return 0
            } else {
            return  sqrt(number)
            }
        case .divisor:
            if number == 0 {
                return 0
            } else {
            return 1 / number
            }
        default:
            return 0
        }
    }
    
}