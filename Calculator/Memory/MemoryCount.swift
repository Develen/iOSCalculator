//
//  Memory.swift
//  Calculator
//
//  Created by Admin on 25.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

class MemoryCount {
   
     static func memoryCounting (memoryNumber: Double, memoryResult: Double, arithmeticMemoryCommand: CalculationCommand) -> Double {
       
        switch arithmeticMemoryCommand {
        case .addition:
                return memoryResult + memoryNumber
        case .subtraction:
        return memoryResult - memoryNumber
                     
        default:
            return 0
        }
    }
}
