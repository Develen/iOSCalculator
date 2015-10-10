//
//  CalculationForMemory.swift
//  Calculator
//
//  Created by Admin on 25.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

public enum CommandForMemory {
    
    case plus
    case minus
    case equalMemory
    case clean
    case none
    
    init () {
        self = .none
    }
}