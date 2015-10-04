//
//  CalculationCommand.swift
//  Calculator
//
//  Created by Admin on 19.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

enum CalculationCommand {
    case addition
    case subtraction
    case multiplication
    case division
    case none
    
    init () {
        self = .none
    }
}