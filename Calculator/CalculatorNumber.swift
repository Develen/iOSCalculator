//
//  CalculatorNumber.swift
//  Calculator
//
//  Created by Admin on 15.10.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation
public class CalculatorNumber {
    private var stringValueField: String? = ""
    private var doubleValueField: Double? = nil
    private var isStringField: Bool = true
    public var isString: Bool {
        return isStringField
    }
    public var stringValue: String {
        get {
            return stringValueField!
        }
        set {
            isStringField = true
            doubleValueField = nil
            stringValueField = newValue
        }
    }
    public var doubleValue: Double {
        get {
            return doubleValueField!
        }
        set {
            stringValueField = nil
            doubleValueField = newValue
            isStringField = false
        }
    }
}