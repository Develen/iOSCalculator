//
//  Calculator.swift
//  Calculator
//
//  Created by Admin on 19.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//
import Foundation

public class Calculator {
    private var firstNumber: CalculatorNumber
    private var secondNumber = CalculatorNumber()
    private var arithmeticCommand = CalculationCommand()
    private var currentState = CurrentState()
    private var point = false
    private var memory = Memory()
    private var extraCommand = ExtraOperation()
    
    public init() {
        firstNumber = CalculatorNumber()
        firstNumber.stringValue = "0"
    }
    
    public func clearAll () {
        firstNumber.stringValue = "0"
        secondNumber.stringValue = ""
        arithmeticCommand = .none
        currentState = .begin
        point = false
        memory.cleanAllMemory()
        extraCommand = .none
    }
    
    public func sendNumber(number: Int) {
        
        if number > CalculatorConstants.maxNumberOfButton || number < CalculatorConstants.minNumberOfButton {
            return
        }
        
        switch currentState {
        case .begin:
            firstNumber.stringValue = "\(number)"
            currentState = .fillingFirstNumber
            
        case .fillingFirstNumber:
            if firstNumber.stringValue == "0" || firstNumber.stringValue == "" {
                firstNumber.stringValue = "\(number)"
            } else {
                firstNumber.stringValue = LimitForDispaly.limitDisplay(firstNumber.stringValue, number: number, maxLength: CalculatorConstants.maxLengthForNumber)
            }
            
        case .operationPressed:
            if secondNumber.stringValue == "-" {
                secondNumber.stringValue = secondNumber.stringValue + "\(number)"
                currentState = .fillingSecondNumber
            } else {
                secondNumber.stringValue = "\(number)"
                currentState = .fillingSecondNumber
            }
            
        case .fillingSecondNumber:
            if secondNumber.stringValue == "0" {
                secondNumber.stringValue = "\(number)"
            } else {
                secondNumber.stringValue = LimitForDispaly.limitDisplay(secondNumber.stringValue, number: number, maxLength: CalculatorConstants.maxLengthForNumber)
            }
            
        default:
            return //TODO: use exceptions
        }
    }
    
    public func runCommand(calculationCommand: CalculationCommand) {
        
        switch currentState {
        case .begin:
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                arithmeticCommand = calculationCommand
                currentState = .operationPressed
                
            default:
                return //TODO: use exceptions
                
            }
            
        case .fillingFirstNumber:
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                arithmeticCommand = calculationCommand
                firstNumber.doubleValue = (firstNumber.stringValue as NSString).doubleValue
                currentState = .operationPressed
                point = false
                
            default:
                return //TODO: use exceptions
            }
            
        case .operationPressed:
            arithmeticCommand = calculationCommand
            
        case .fillingSecondNumber:
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                if secondNumber.stringValue == "" {
                    arithmeticCommand = calculationCommand
                    currentState = .operationPressed
                } else if firstNumber.isString == true {
                    firstNumber.doubleValue = (firstNumber.stringValue as NSString).doubleValue
                    firstNumber.doubleValue = LogicOfCalulation.calculateResult(firstNumber.doubleValue, secondNumber: secondNumber.stringValue, arithmeticCommand: arithmeticCommand)
                } else {
                    firstNumber.doubleValue = LogicOfCalulation.calculateResult(firstNumber.doubleValue, secondNumber: secondNumber.stringValue, arithmeticCommand: arithmeticCommand)
                }
                
                arithmeticCommand = calculationCommand
                currentState = .operationPressed
                point = false
                
            default:
                return //TODO: use exceptions
            }
            
        case .operationPressed:
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                arithmeticCommand = calculationCommand
                
            default:
                return //TODO: use exceptions
            }
            
        default:
            return //TODO: use exceptions
        }
    }
    
    public func equalResult() {
        
        switch currentState {
        case .begin:
            return
            
        case .fillingFirstNumber:
            return
            
        case .fillingSecondNumber:
            if secondNumber.stringValue == "" {
                currentState = .begin
                arithmeticCommand = .none
            } else {
                if firstNumber.isString == true {
                    firstNumber.doubleValue = (firstNumber.stringValue as NSString).doubleValue
                } else {
                    firstNumber.doubleValue = LogicOfCalulation.calculateResult(firstNumber.doubleValue, secondNumber: secondNumber.stringValue, arithmeticCommand: arithmeticCommand)
                }
                currentState = .begin
                point = false
            }
            
        case .operationPressed:
            currentState = .begin
            arithmeticCommand = .none
            
        default:
            return
        }
    }
    
    public func positiveOrNegativeNumber () {
        
        switch currentState {
        case .begin:
            if firstNumber.isString == true {
                if Array(firstNumber.stringValue)[0] == "-" && firstNumber.stringValue != "-" {
                    firstNumber.stringValue = dropFirst(firstNumber.stringValue)
                    // in swift 2.0  String(original.characters.dropFirst())
                    //or use x.removeAtIndex(x.startIndex)
                } else if Array(firstNumber.stringValue)[0] != "-" && (firstNumber.stringValue == "0"
                    || firstNumber.stringValue == "") {
                        firstNumber.stringValue = "-"
                        currentState = .fillingFirstNumber
                } else {
                    firstNumber.stringValue = "-" + firstNumber.stringValue
                }
            } else {
                if firstNumber.doubleValue == 0 {
                    return
                } else {
                    firstNumber.doubleValue = (-1) * firstNumber.doubleValue
                }
                
            }
            
        case .fillingFirstNumber:
            if firstNumber.isString == true {
                if Array(firstNumber.stringValue)[0] == "-" {
                    firstNumber.stringValue = dropFirst(firstNumber.stringValue)
                    // in swift 2.0  String(original.characters.dropFirst())
                    //or use x.removeAtIndex(x.startIndex)
                } else if firstNumber.stringValue == "0" {
                    firstNumber.stringValue = "-"
                } else {
                    firstNumber.stringValue = "-" + firstNumber.stringValue
                }
            } else {
                if firstNumber.doubleValue == 0 {
                    return
                } else {
                    firstNumber.doubleValue = (-1) * firstNumber.doubleValue
                }
            }
            
        case .operationPressed:
            secondNumber.stringValue = "-"
            currentState = .fillingSecondNumber
            
        case .fillingSecondNumber:
            if secondNumber.isString == true {
                if Array(secondNumber.stringValue)[0] == "-" {
                    secondNumber.stringValue = dropFirst(secondNumber.stringValue)
                    // in swift 2.0  String(original.characters.dropFirst())
                    //or use x.removeAtIndex(x.startIndex)
                } else if Array(secondNumber.stringValue)[0] != "-" && secondNumber.stringValue == "0" {
                    secondNumber.stringValue = "-"
                } else {
                    secondNumber.stringValue = "-" + secondNumber.stringValue
                }
            } else {
                if secondNumber.doubleValue == 0 {
                    return
                } else {
                    secondNumber.doubleValue = (-1) * secondNumber.doubleValue
                }
            }
            
        default:
            return
        }
    }
    
    public func showDisplay() -> String {
        
        switch currentState {
        case .begin, .fillingFirstNumber, .operationPressed:
            if firstNumber.isString == true {
                return firstNumber.stringValue
            } else {
                return ShowCorrectResult.showLimitingResult(firstNumber.doubleValue, maxLength: CalculatorConstants.maxLengthForDisplay)
            }
            
        case .fillingSecondNumber:
            if secondNumber.isString == true {
                return secondNumber.stringValue
            } else {
                return ShowCorrectResult.showLimitingResult(secondNumber.doubleValue, maxLength: CalculatorConstants.maxLengthForDisplay)
            }
            
        default:
            return "0"
        }
    }
    
    public func showPoint() {
        
        if point == false {
            point = true
            
            switch currentState {
            case .begin:
                point = false
                
            case .fillingFirstNumber:
                firstNumber.stringValue = firstNumber.stringValue + "."
                
            case .fillingSecondNumber:
                if secondNumber.stringValue == "" {
                    point = false
                    return
                } else {
                    secondNumber.stringValue = secondNumber.stringValue + "."
                }
                
            case .operationPressed:
                point = false
                
            default:
                return
            }
        } else if point == true {
            return
        }
    }
    
    public func removingNumber () {
        
        switch currentState {
        case .begin:
            return
            
        case .fillingFirstNumber:
            if firstNumber.stringValue == "0" || firstNumber.stringValue == "" ||  firstNumber.stringValue == "-" {
                firstNumber.stringValue = "0"
            } else {
                firstNumber.stringValue = RemoveNumber.removeLastOne(firstNumber.stringValue)
            }
            
        case .fillingSecondNumber:
            if secondNumber.stringValue == "" {
                return
            } else {
                secondNumber.stringValue = RemoveNumber.removeLastOne(secondNumber.stringValue)
            }
            
        case .operationPressed:
            return
            
        default:
            return
        }
    }
    
    public func memory(memoryCommand: CommandForMemory) {
        var currentNumber: Double = 0
        
        switch currentState {
        case  .begin:
            if firstNumber.isString == true {
                currentNumber = (firstNumber.stringValue as NSString).doubleValue
            } else {
                currentNumber = firstNumber.doubleValue
            }
            
        case .fillingFirstNumber:
            if firstNumber.isString == true {
                currentNumber = (firstNumber.stringValue as NSString).doubleValue
            } else {
                currentNumber = firstNumber.doubleValue
            }
            
        case .operationPressed:
            if firstNumber.isString == true {
                currentNumber = (firstNumber.stringValue as NSString).doubleValue
            } else {
                currentNumber = firstNumber.doubleValue
            }
            
        case .fillingSecondNumber:
            if secondNumber.isString == true {
                currentNumber = (secondNumber.stringValue as NSString).doubleValue
            } else {
                currentNumber = secondNumber.doubleValue
            }
            
        default:
            return
        }
        
        switch memoryCommand{
        case .plus:
            memory.memoryManager(currentNumber, arithmeticMemoryCommand: .addition)
            
        case .minus:
            memory.memoryManager(currentNumber, arithmeticMemoryCommand: .subtraction)
            
        case .clean:
            memory.cleanAllMemory()
            
        case .equalMemory:
            
            switch currentState {
            case .begin:
                firstNumber.doubleValue = memory.equalMemory()
                
            case .fillingFirstNumber:
                currentState = .begin
                
            case .fillingSecondNumber:
                firstNumber.doubleValue = memory.equalMemory()
                currentState = .begin
                
            case .operationPressed:
                firstNumber.doubleValue = memory.equalMemory()
                currentState = .begin
                
            default: return
            }
            
        default: return
        }
    }
    
    public func showLabel () -> String {
        return memory.showLabel()
    }
    
    public func cleanDisplay() {
        point = false
        
        switch currentState {
        case .begin:
            firstNumber.stringValue = "0"
            
        case .fillingFirstNumber:
            firstNumber.stringValue = "0"
            
        case .operationPressed:
            return
            
        case .fillingSecondNumber:
            secondNumber.stringValue = "0"
        }
    }
}
