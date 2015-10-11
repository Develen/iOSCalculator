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
    
     func testDisplayedNumberAfterOperation() {
        calculator.sendNumber(7)
        calculator.runCommand(.multiplication)
        var x = calculator.showDisplay()
        XCTAssert (calculator.showDisplay() == "7", "Displayed NumberAfterOperation failed")
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
    func testCalculator_showingPoint() {
        calculator.sendNumber(5)
        calculator.sendNumber(4)
        
        calculator.showPoint()

        XCTAssert(calculator.showDisplay() == "54.", "decimal result failed")
        
        
    }

    
    func testCalculator_simpleCountingDecimalNumbers() {
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
    func testPointTwiceInTheFirstNumber() {
        calculator.sendNumber(7)
        calculator.sendNumber(8)
        calculator.showPoint()
        calculator.sendNumber(9)
        calculator.showPoint()
        XCTAssert (calculator.showDisplay() == "78.9", "PointTwiceInTheFirstNumber failed")
    }
    
    func testPointTwiceInTheSecondNumber() {
        calculator.sendNumber(5)
        calculator.sendNumber(8)
        calculator.showPoint()
        calculator.sendNumber(9)
        calculator.runCommand(.subtraction)
        calculator.sendNumber(5)
        calculator.showPoint()
        calculator.sendNumber(2)
        calculator.showPoint()
        calculator.sendNumber(8)
        XCTAssert (calculator.showDisplay() == "5.28", "PointTwiceInThSecondNumber failed")
    }
    
    func testMemoryLabelAfterCleanAll() {
        calculator.sendNumber(5)
        calculator.memory(.plus)
        calculator.runCommand(.addition)
        calculator.sendNumber(6)
        calculator.memory(.minus)
        XCTAssert (calculator.showLabel() == "M", "MemoryLabelAfterCleanAll faild")
        
    }
    func testNegativeFirstPressed() {
        calculator.positiveOrNegativeNumber()
        
        XCTAssert (calculator.showDisplay() == "-", "NegativeFirstPressed faild")
        
    }
    func testNegativeFirstNumberWithPoint() {
        calculator.positiveOrNegativeNumber()
        calculator.sendNumber(0)
        calculator.showPoint()
        calculator.sendNumber(4)
        calculator.sendNumber(5)

        
        XCTAssert (calculator.showDisplay() == "-0.45", "NegativeFirstNumberWithPoint faild")
        
    }
    func testSeveralTimeNegativeToPositive() {
        calculator.positiveOrNegativeNumber()
        calculator.sendNumber(5)
        calculator.showPoint()
        calculator.sendNumber(4)
        calculator.sendNumber(5)
        calculator.positiveOrNegativeNumber()
        XCTAssert (calculator.showDisplay() == "5.45", "NegativeFirstNumberWithPoint faild")
        
    }
    func testNegativeResultAndContinueCounting() {
        
        calculator.sendNumber(5)
        calculator.runCommand(.addition)
        calculator.sendNumber(4)
        calculator.sendNumber(5)
        calculator.equalResult()
        calculator.positiveOrNegativeNumber()
        calculator.runCommand(.addition)
        calculator.sendNumber(6)
        calculator.equalResult()
        
        XCTAssert (calculator.showDisplay() == "-44", "NegativeResultAndContinueCounting faild")
        
    }

    
    func testUsingNegativeAfterEqualLargeNumber() {
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        
      
        calculator.runCommand(.multiplication)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.sendNumber(9)
        calculator.equalResult()
        calculator.positiveOrNegativeNumber()
        
        XCTAssert (calculator.showDisplay() == "-9.999998E+13", "MemoryLabelAfterCleanAll faild")
        
    }
    func testCleanDisplaySecondNumber() {
        
        calculator.sendNumber(5)
        calculator.runCommand(.addition)
        calculator.sendNumber(4)
        calculator.sendNumber(5)
        calculator.cleanDisplay()
    
        XCTAssert (calculator.showDisplay() == "0", "CleanDisplaySecondNumber faild")
        
    }
    func testCleanDisplayAfterEqual() {
        
        calculator.sendNumber(5)
        calculator.runCommand(.addition)
        calculator.sendNumber(4)
        calculator.sendNumber(5)
        calculator.equalResult()
        calculator.cleanDisplay()
        
        XCTAssert (calculator.showDisplay() == "0", "NegativeResultAndContinueCounting faild")
        
    }
    func testCleanDisplayAndContinueCounting() {
        
        calculator.sendNumber(2)
         calculator.sendNumber(5)
        calculator.runCommand(.division)
        calculator.sendNumber(2)
       
        calculator.equalResult()
        calculator.runCommand(.addition)
        calculator.sendNumber(4)
        calculator.showPoint()
        
        calculator.cleanDisplay()
        calculator.sendNumber(2)
        calculator.showPoint()
        calculator.sendNumber(5)
        calculator.equalResult()
        
        XCTAssert (calculator.showDisplay() == "15", "leanDisplayAndContinueCounting faild")
        
    }
    
    
}
