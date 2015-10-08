//
//  CalculatorTest.swift
//  Calculator
//
//  Created by Admin on 06.10.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit
import XCTest
import Calculator


class CalculatorTest: XCTestCase {
    
   
    //or var calculator = Calculator()
    
    
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        self.calculator = Calculator()
    }
    
    func testMemoryLabelAfterCleanAll() {
       calculator.sendNumber(5)
        calculator.memory(.plus)
        calculator.runCommand(.addition)
        calculator.sendNumber(6)
        calculator.memory(.minus)
        XCTAssert (calculator.showLabel() == "M", "MemoryLabelAfterCleanAll faild")
        
    }
  
  
   
    func testCalculator_SimpleAddition() {
        
        
        calculator.sendNumber(5)
        calculator.sendNumber(4)
        
        calculator.runCommand(.addition)
        
        calculator.sendNumber(9)
        calculator.sendNumber(1)
        
        calculator.equalResult()
        XCTAssert (calculator.showDisplay() == "145", "addition faild")
    }


    func testCalculator_SimpleSubtraction() {
        calculator.sendNumber(5)
        calculator.sendNumber(4)
        
        calculator.runCommand(.subtraction)
        
        calculator.sendNumber(9)
        calculator.sendNumber(1)
        
        calculator.equalResult()
        XCTAssert(calculator.showDisplay() == "-37", "subtraction faild")
    }
    
    func testCalculator_SimpleMultiplication() {
        calculator.sendNumber(5)
        calculator.sendNumber(4)
        
        calculator.runCommand(.multiplication)
        
        calculator.sendNumber(9)
        calculator.sendNumber(1)
        
        calculator.equalResult()
        XCTAssert(calculator.showDisplay() == "4914", "multiplication faild")
        
    }
    
    func testCalculator_SimpleDivision() {
        calculator.sendNumber(5)
        calculator.sendNumber(4)
        
        calculator.runCommand(.division)
        
        calculator.sendNumber(9)
        calculator.sendNumber(1)
        
        calculator.equalResult()
        XCTAssert(calculator.showDisplay() == "0.59340659341", "division failed")
        
    }
    
    func testCalculator_TreeTimesOfMultiplication() {
        calculator.sendNumber(2)
        calculator.sendNumber(1)
        
        calculator.runCommand(.multiplication)
        
        calculator.sendNumber(5)
        
        calculator.runCommand(.multiplication)
        
        
        calculator.sendNumber(2)
        calculator.sendNumber(3)
        
        calculator.runCommand(.multiplication)
        
       
        
        calculator.sendNumber(2)
        
        calculator.runCommand(.multiplication)
        
        XCTAssert(calculator.showDisplay() == "4830", " multiplication third time failed")
        
    }
    
    
    func testCalculator_changingOperationsAfterEqual() {
        calculator.sendNumber(2)
        
        calculator.runCommand(.addition)
        
        calculator.sendNumber(5)
        
        calculator.equalResult()
        
   
        
        calculator.runCommand(.multiplication)
        
        calculator.sendNumber(2)
        calculator.equalResult()
        
        XCTAssert(calculator.showDisplay() == "14", "changingOperationsAfterEqual the end failed")
        
    }
    
    
    
    func testCalculator_changingOperations() {
        
        calculator.sendNumber(9)
        
        calculator.runCommand(.division)
        
        calculator.sendNumber(2)
        
        calculator.runCommand(.addition)
        
        
        calculator.runCommand(.multiplication)
        
        calculator.sendNumber(5)
        
        calculator.equalResult()
        
        XCTAssert(calculator.showDisplay() == "22.5", "changingOperations the end failed")
        
    }
    
    func testCalculator_removeSecondNumber() {
        
        calculator.sendNumber(9)
        calculator.sendNumber(5)
        calculator.sendNumber(6)
        
        calculator.runCommand(.division)
        
        calculator.sendNumber(2)
        calculator.sendNumber(9)
        calculator.sendNumber(4)
        
        calculator.removingNumber()
        
        
        
        calculator.removingNumber()
        
        
        calculator.removingNumber()
        
        
        
        calculator.removingNumber()
        
                calculator.sendNumber(5)
        
        calculator.equalResult()
        
        XCTAssert(calculator.showDisplay() == "191.2", "removeSecondNumber result failed")
        
    }
    
    func testCalculator_decimalnumbers() {
        calculator.sendNumber(5)
        calculator.sendNumber(4)
        
        calculator.showPoint()
        
        calculator.sendNumber(6)
         calculator.sendNumber(0)
        
        calculator.runCommand(.multiplication)
        
        calculator.sendNumber(2)
        calculator.sendNumber(5)
        calculator.showPoint()
        calculator.sendNumber(3)
        
        
        calculator.equalResult()
        XCTAssert(calculator.showDisplay() == "1381.38", "decimal result failed")


    }
  

}
