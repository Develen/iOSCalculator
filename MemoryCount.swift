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
       
                if arithmeticMemoryCommand == .plus {
                
                return memoryResult + memoryNumber
                
            } else if arithmeticMemoryCommand == .minus {
                return memoryResult - memoryNumber
                
            } else if arithmeticMemoryCommand == .equalMemory {
                
                return memoryResult
            }
            else {
                return 0.0
        }
       
        
    }
    
}
    
