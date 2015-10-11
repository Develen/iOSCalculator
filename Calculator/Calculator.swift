//
//  Calculator.swift
//  Calculator
//
//  Created by Admin on 19.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//
import Foundation

public class Calculator {
    private var firstNumber = "0"
    private var secondNumber = ""
    private var arithmeticCommand = CalculationCommand()
    private var currentState = CurrentState()
    private var resultAsFirstNumber: Double = 0
    private var point = false
    private var memory = Memory()
    private var extraCommand = ExtraOperation()
    
    public init() {
    }
    
    public func clearAll () {
        firstNumber = "0"
        secondNumber = ""
        arithmeticCommand = .none
        currentState = .begin
        resultAsFirstNumber = 0
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
           
//            if firstNumber == "-0" {
//                firstNumber = "-" + "\(number)"
//                 resultAsFirstNumber = (firstNumber as NSString).doubleValue
//                 currentState = .fillingFirstNumber
//            } else {
            firstNumber = "\(number)"
            secondNumber = ""
            currentState = .fillingFirstNumber
            resultAsFirstNumber = (firstNumber as NSString).doubleValue
            //}
            
        case .fillingFirstNumber:
            if firstNumber == "0" || firstNumber == "" {
                firstNumber = "\(number)"
                resultAsFirstNumber = (firstNumber as NSString).doubleValue

            } else {
                firstNumber = LimitForDispaly.limitDisplay(firstNumber, number: number, maxLength: CalculatorConstants.maxLengthForNumber)
                resultAsFirstNumber = (firstNumber as NSString).doubleValue
            }
            
        case .operationPressed:
            if secondNumber == "-" {
            secondNumber = secondNumber + "\(number)"
            currentState = .fillingSecondNumber
            }
            else {
                secondNumber = "\(number)"
                currentState = .fillingSecondNumber
            }

            
        case .fillingSecondNumber:
            if secondNumber == "0" {
                secondNumber = "\(number)"
            } else {
                secondNumber = LimitForDispaly.limitDisplay(secondNumber, number: number, maxLength: CalculatorConstants.maxLengthForNumber)
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
                if secondNumber == "" {
                    arithmeticCommand = calculationCommand
                    currentState = .operationPressed
                } else {
                    
                    resultAsFirstNumber = LogicOfCalulation.calculateResult(resultAsFirstNumber, secondNumber: secondNumber, arithmeticCommand: arithmeticCommand)
                    
                    
                    arithmeticCommand = calculationCommand
                    currentState = .operationPressed
                    point = false
                }
                
                
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
//    public func runExtraCommand (extraCalculationCommand : ExtraOperation) {
//        switch currentState {
//        case .begin:
//            resultAsFirstNumber = LogicOfExtraCount.countingExtraOperation(resultAsFirstNumber, extraOperation: extraCalculationCommand)
//            firstNumber = "\(resultAsFirstNumber)"
//        case .fillingFirstNumber:
//            resultAsFirstNumber = LogicOfExtraCount.countingExtraOperation(resultAsFirstNumber, extraOperation: extraCalculationCommand)
//            firstNumber = "\(resultAsFirstNumber)"
//        case .operationPressed:
//            resultAsSecondNumber = LogicOfExtraCount.countingExtraOperation(resultAsFirstNumber, extraOperation: extraCalculationCommand)
//            currentState = .fillingSecondNumber
//        }
//    }
    
    public func equalResult() {
        
        switch currentState {
        case .begin:
            return
        case .fillingFirstNumber:
            return
        case .fillingSecondNumber:
            if secondNumber == "" {
                currentState = .begin
                arithmeticCommand = .none
            } else {
                
                  resultAsFirstNumber = LogicOfCalulation.calculateResult(resultAsFirstNumber, secondNumber: secondNumber, arithmeticCommand: arithmeticCommand)
                currentState = .begin
                firstNumber = "\(resultAsFirstNumber)"
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
            if Array(firstNumber)[0] == "-" {
                firstNumber = dropFirst(firstNumber)
                resultAsFirstNumber = (-1) * resultAsFirstNumber
                // in swift 2.0  String(original.characters.dropFirst())
                //or use x.removeAtIndex(x.startIndex)
            } else if Array(firstNumber)[0] != "-" && firstNumber == "0" {
                firstNumber = "-"
                currentState = .fillingFirstNumber
            } else {
                firstNumber = "-" + firstNumber
                resultAsFirstNumber = (-1) * resultAsFirstNumber
            }
         case .fillingFirstNumber:
            if Array(firstNumber)[0] == "-" {
                firstNumber = dropFirst(firstNumber)
                resultAsFirstNumber = (firstNumber as NSString).doubleValue
            } else {
                firstNumber = "-" + firstNumber
                resultAsFirstNumber = (firstNumber as NSString).doubleValue

            }

        case .operationPressed:
            secondNumber = "-"
            currentState = .fillingSecondNumber
            
        case .fillingSecondNumber:
             if Array(secondNumber)[0] == "-" {
                secondNumber = dropFirst(secondNumber)
             } else {
               secondNumber = "-" + secondNumber

            }
      
        default:
            return
        }
    }
   
    
    public func showDisplay() -> String {
        
//        var currentNumber = getCurrentNumber()
        switch currentState {
        case .begin:
            return ShowCorrectResult.showLimitingResult(resultAsFirstNumber, maxLength: CalculatorConstants.maxLengthForDisplay)
        case .fillingFirstNumber:
            return firstNumber
        case .operationPressed:
            return ShowCorrectResult.showLimitingResult(resultAsFirstNumber, maxLength: CalculatorConstants.maxLengthForDisplay)
        case .fillingSecondNumber:
            return secondNumber
        default:
            return "0"
        }
        
    }
    
//    
//    private func getCurrentNumber () -> Double {
//        
//        switch currentState {
//        case .begin:
//            if firstNumber == "0" {
//                return 0
//            } else {
//                return resultAsFirstNumber
//                
//            }
//            
//        case .fillingFirstNumber, .operationPressed:
//            return resultAsFirstNumber
//            
//        case .fillingSecondNumber:
//            return (secondNumber as NSString).doubleValue
//            
//        default:
//            return 0
//        }
//    }
//    
    public func showPoint() {
        
        if point == false {
            point = true
            
            switch currentState {
            case .begin:
                point = false
                
            case .fillingFirstNumber:
                firstNumber = firstNumber + "."
                resultAsFirstNumber = (firstNumber as NSString).doubleValue
                
            case .fillingSecondNumber:
                if secondNumber == "" {
                    point = false
                    return
                } else {
                    secondNumber = secondNumber + "."
                    
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
            if firstNumber == "0" {
                return
            } else {
                firstNumber = RemoveNumber.removeLastOne(firstNumber)
                resultAsFirstNumber = (firstNumber as NSString).doubleValue
                
            }
            
        case .fillingSecondNumber:
            if secondNumber == "" {
                return
            } else {
                secondNumber = RemoveNumber.removeLastOne(secondNumber)
                
                
            }
            
        case .operationPressed:
            
            return
            
        default:
            return
        }
    }
    
    public func memory(memoryCommand: CommandForMemory) {
        var currentNumber: Double = 0
        //let currentNumber = getCurrentNumber()
        switch currentState {
        case  .begin:
            currentNumber = resultAsFirstNumber
        case .fillingFirstNumber:
            currentNumber = resultAsFirstNumber
        case .operationPressed:
            currentNumber = resultAsFirstNumber
        case .fillingSecondNumber:
            currentNumber = (secondNumber as NSString).doubleValue
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
                resultAsFirstNumber = memory.equalMemory()
            case .fillingFirstNumber:
                currentState = .begin
            case .fillingSecondNumber:
                resultAsFirstNumber = memory.equalMemory()
                currentState = .begin
            case .operationPressed:
                resultAsFirstNumber = memory.equalMemory()
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
            firstNumber = "0"
            resultAsFirstNumber = 0
        case .fillingFirstNumber:
            firstNumber = "0"
            resultAsFirstNumber = 0
        case .operationPressed:
            return
        case .fillingSecondNumber:
            secondNumber = "0"
        }
    }
}
