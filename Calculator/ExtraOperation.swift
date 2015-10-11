//
//  ExtraOperation.swift
//  Calculator
//
//  Created by Admin on 11.10.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

public enum ExtraOperation {
    case percent
    case root
    case divisor
    case none
    
    init() {
        self = .none
    }
}