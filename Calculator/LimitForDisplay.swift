//
//  LimitForDisplay.swift
//  Calculator
//
//  Created by Admin on 28.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

class LimitForDispaly {
    static func limitDisplay (operandNumber: String, number: Int, maxLength: Int) -> String {
        
        if count(operandNumber) < maxLength {
            return operandNumber + "\(number)"
            
        } else {
            return operandNumber
        }
    }
}