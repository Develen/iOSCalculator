//
//  MemoryTest.swift
//  Calculator
//
//  Created by Admin on 08.10.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit
import XCTest
import Calculator


class MemoryTest: XCTestCase {
    var memory: Memory!
    
    override func setUp() {
        super.setUp()
        self.memory = Memory()
    }

    
    func testMemory() {
        memory.memoryManager(2, arithmeticMemoryCommand: .addition)
          memory.memoryManager(3, arithmeticMemoryCommand: .subtraction)
         XCTAssert (memory.showMemoryDisplay() == "-1", "addition faild")
    }
}