//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Admin on 15.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit
import XCTest
import Calculator


class ShowCorrectResultTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
 
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testShowCorrectResult_decimal() {
       
        XCTAssert(ShowCorrectResult.showLimitingResult(44.34322224252233, maxLength: 10) == "44.3432222", "decimal")
        XCTAssert(ShowCorrectResult.showLimitingResult(44.24688, maxLength: 7) == "44.2469", "decimal with round")

    }
      func testShowCorrectResult_negativeDecimal() {
    XCTAssert(ShowCorrectResult.showLimitingResult(-44.34322224252233, maxLength: 10) == "-44.343222", "negative decimal")
    XCTAssert(ShowCorrectResult.showLimitingResult(-24.0668, maxLength: 7) == "-24.067", "negative decimal with round")
    }
    
    func testShowCorrectResult_integer() {
        XCTAssert(ShowCorrectResult.showLimitingResult(44444444444.34322224252233, maxLength: 10) == "4.4444E+10", "large integer in double number")
        XCTAssert(ShowCorrectResult.showLimitingResult(4444444445.634322224252233, maxLength: 10) == "4444444446", "integer = maxlength in double number")
        XCTAssert(ShowCorrectResult.showLimitingResult(444444444.634322224252233, maxLength: 10) == "444444445", "integer = maxlength -1 in double number")
        XCTAssert(ShowCorrectResult.showLimitingResult(-5263567986415.34322224252233, maxLength: 10) == "-5.264E+12", "negative large integer in double number")
        
    }
     func testShowCorrectResult_negativeInteger() {
    XCTAssert(ShowCorrectResult.showLimitingResult(-892536985.634322224252233, maxLength: 10) == "-892536986", "negative integer = maxlength in double number")
    XCTAssert(ShowCorrectResult.showLimitingResult(-586936527.4252233, maxLength: 10) == "-586936527", "negative integer = maxlength -1 in double number")
    XCTAssert(ShowCorrectResult.showLimitingResult(99999999999.999, maxLength: 10) == "10.000E+10", "negative integer = maxlength -1 in double number")
        
    }
    
    func testShowCorrectResult_tooSmallNumberNegative() {
        
        XCTAssert(ShowCorrectResult.showLimitingResult(-0.00078, maxLength: 7) == "-0.0008", "negative round small number")
        
        XCTAssert(ShowCorrectResult.showLimitingResult(-0.00001905177341, maxLength: 13) == "-0.0000190518", "negative too small number with large decimal")
        XCTAssert(ShowCorrectResult.showLimitingResult(-0.000000000000867, maxLength: 13) == "-8.7E-13", "negative too small number with decimal 0 more than maxlength")
           }
    func testShowCorrectResult_tooSmallNumber() {
       
        XCTAssert(ShowCorrectResult.showLimitingResult(0.000078, maxLength: 7) == "0.00008", " round small number")
        
        XCTAssert(ShowCorrectResult.showLimitingResult(0.000001905191341, maxLength: 13) == "0.00000190519", "too small number with large decimal")
   
        XCTAssert(ShowCorrectResult.showLimitingResult(0.0000000000000867, maxLength: 13) == "8.7E-14", "too small number with decimal 0 more than maxlength")
    }
    
    func testShowCorrectResult_exactlyNumbers() {
        
        XCTAssert(ShowCorrectResult.showLimitingResult(0, maxLength: 7) == "0", " round small number")
        
        XCTAssert(ShowCorrectResult.showLimitingResult(-1.00, maxLength: 13) == "-1", "too small number with large decimal")
        
        XCTAssert(ShowCorrectResult.showLimitingResult(100, maxLength: 13) == "100", "too small number with decimal 0 more than maxlength")
    }
    
    
    func testShowCorrectResult_maxAndMinDoubleNumber() {
        
        
        XCTAssert(ShowCorrectResult.showLimitingResult(DBL_MAX, maxLength: 10) == "large number", " max double")
        XCTAssert(ShowCorrectResult.showLimitingResult(DBL_MIN, maxLength: 13) == "2.2E-308", "min double")
        
    }
    
    
    func testShowCorrectResult_impossibleErrors() {
       XCTAssert(ShowCorrectResult.showLimitingResult(56.399887455, maxLength: 5) == "incorrect max length of display", " maxlength less than 5")
        XCTAssert(ShowCorrectResult.showLimitingResult(56.399887455, maxLength: -4) == "incorrect max length of display", " negative maxlength")
              XCTAssert(ShowCorrectResult.showLimitingResult(548763235689744132365678987543568784646576768898965, maxLength: 10) == "large number", "too large number of integer")
    }
    
    func testShowCorrectResult_minusNul() {
        
        XCTAssert(ShowCorrectResult.showLimitingResult(-0, maxLength: 10) == "0", "decimal")
        
        
    }

    

 
    
    
}
