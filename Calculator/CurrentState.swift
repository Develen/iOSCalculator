//
//  CurrentState.swift
//  Calculator
//
//  Created by Admin on 19.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

enum CurrentState {
    case begin
    case fillingFirstNumber
    case fillingSecondNumber
    case continueCounting
   

    
    init() {
        self = .begin
    }
}
