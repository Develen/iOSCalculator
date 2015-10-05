//
//  Memory.swift
//  Calculator
//
//  Created by Admin on 25.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

class MemoryCount {
    
    class func memoryCounting (memoryNumber: Double, memoryResult: Double, arithmeticMemoryCommand: CommandForMemory) -> Double {
       
        switch arithmeticMemoryCommand {
        case .plus:
                return memoryResult + memoryNumber
        case .minus:
        return memoryResult - memoryNumber
        case .equalMemory:
               return memoryResult
                
        default:
            return 0
        }
    }
}
