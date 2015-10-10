//
//  Memory.swift
//  Calculator
//
//  Created by Admin on 08.10.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation
public class Memory {
 
    private var memoryResult: Double = 0
    
    public init() {
        
    }
    
    public func memoryManager(memoryNumber:Double, arithmeticMemoryCommand: CalculationCommand){
        memoryResult = MemoryCount.memoryCounting(memoryNumber, memoryResult: memoryResult, arithmeticMemoryCommand: arithmeticMemoryCommand)
    
}

   
    public func equalMemory() -> Double {
        return memoryResult
    
    }
    public func  cleanAllMemory () {
        memoryResult = 0
        
    }
    
    public func showLabel () -> String {
        if memoryResult != 0 {
                        return "M"
                    }else {
                        return ""
                    }
    }
    public func showMemoryDisplay() -> String {
         return ShowCorrectResult.showLimitingResult(memoryResult, maxLength: CalculatorConstants.maxLengthForDisplay)
    }
}
