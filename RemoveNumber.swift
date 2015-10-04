//
//  RemoveNumber.swift
//  Calculator
//
//  Created by Admin on 25.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

class RemoveNumber {
    class func removeLastOne (result: String) -> String {
        
        return result.substringToIndex(result.endIndex.predecessor())
        
        }
    
    init () {
        
    }
}
