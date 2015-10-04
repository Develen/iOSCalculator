//
//  Calculator.swift
//  Calculator
//
//  Created by Admin on 19.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

class Calculator {
    //5M+  + 6 M- + 3M+ MR = 8
    private var firstNumber = ""
    private var secondNumber = ""
    private var amountForDisplay = ""
    private var arithmeticCommand = CalculationCommand()
    private var currentState = CurrentState()
    private var resultAsFirstNumber: Double = 0
    private var point = false
    private var memoryNumber: Double = 0
    private var memoryResult: Double = 0
    private var arithmeticMemoryCommand = CommandForMemory()
  
    
    
    func clearAll () {
        firstNumber = ""
        secondNumber = ""
        arithmeticCommand = .none
        currentState = .begin
        resultAsFirstNumber = 0
        amountForDisplay = ""
        point = false
        //memoryNumber = 0
        //memoryResult = 0
        //arithmeticMemoryCommand = .none
    }
    
    func sendNumber(number: Int) {
        
        if number > 9 || number < 0 {
            return
        }
        
        switch currentState {
        case .begin:
            firstNumber = "\(number)"
            amountForDisplay = firstNumber
            secondNumber = ""
            currentState = .fillingFirstNumber
            
        case .fillingFirstNumber:
            if firstNumber == "0" {
                firstNumber = "\(number)"
                amountForDisplay = firstNumber
            } else {
                firstNumber = LimitForDispaly.limitDisplay(firstNumber, number: number, maxLength: 7)
                amountForDisplay = firstNumber
            }
            
        case .fillingSecondNumber:
            if secondNumber == "0" {
                secondNumber = "\(number)"
                amountForDisplay = secondNumber
            } else {
                secondNumber = LimitForDispaly.limitDisplay(secondNumber, number: number, maxLength: 7)
                amountForDisplay = secondNumber
            }
            
        case .continueCounting:
            if firstNumber == "" {
               firstNumber = "\(number)"
                amountForDisplay = firstNumber
                resultAsFirstNumber = (amountForDisplay as NSString).doubleValue
                currentState = .fillingFirstNumber
                
            } else {
                secondNumber = "\(number)"
                currentState = .fillingSecondNumber
                amountForDisplay = secondNumber
            }
            
        default:
            return
        }
        
    }
    
    func runCommand(calculationCommand: CalculationCommand) {
        
        switch currentState {
        case .begin:
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                arithmeticCommand = calculationCommand
                currentState = .continueCounting
                
            default:
                return
                
            }
            
        case .fillingFirstNumber:
            resultAsFirstNumber = (firstNumber as NSString).doubleValue
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                arithmeticCommand = calculationCommand
                currentState = .fillingSecondNumber
                point = false
                
            default:
                return
            }
            
        case .fillingSecondNumber:
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                if secondNumber == "" {
                    arithmeticCommand = calculationCommand
                } else {
               
                resultAsFirstNumber = LogicOfCalulation.calculateResult(resultAsFirstNumber, secondNumber: secondNumber, arithmeticCommand: arithmeticCommand)
                arithmeticCommand = calculationCommand
                currentState = .continueCounting
                amountForDisplay = "\(resultAsFirstNumber)"
                point = false
                }
               
                
            default:
                return
            }
            
        case .continueCounting:
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                arithmeticCommand = calculationCommand
                
            default:
                return
            }
            
        default:
            return
        }
    }
    
    func equalResult() {
        
        switch currentState {
        case .begin:
            return
        case .fillingFirstNumber:
            return
        case .fillingSecondNumber:
            resultAsFirstNumber = LogicOfCalulation.calculateResult(resultAsFirstNumber, secondNumber: secondNumber, arithmeticCommand: arithmeticCommand)
            amountForDisplay = "\(resultAsFirstNumber)"
            currentState = .begin
            point = false
        case .continueCounting:
            currentState = .begin
            arithmeticCommand = .none
        }
    }
    
    func showDisplay() -> String {
        
        switch currentState {
        case .begin:
            if firstNumber == "" {
                return ""
            } else {
                return ShowCorrectResult.showLimitingResult(resultAsFirstNumber, maxLength: 14)
               
            }
            
        case .fillingFirstNumber:
            return amountForDisplay
            
        case .fillingSecondNumber:
            return amountForDisplay
            
        case .continueCounting:
            return ShowCorrectResult.showLimitingResult(resultAsFirstNumber, maxLength: 14)
        
        default:
            return ""
        }
    }
    
    func showPoint() {
        
        if point == false {
            point = true
            
            switch currentState {
            case .begin:
                point = false
                
            case .fillingFirstNumber:
                firstNumber = firstNumber + "."
                amountForDisplay = firstNumber
                
            case .fillingSecondNumber:
                if secondNumber == "" {
                    point = false
                    return
                } else {
                    secondNumber = secondNumber + "."
                    amountForDisplay = secondNumber
                }
                
            case .continueCounting:
                point = false
                
            default:
                return
            }
        } else if point == true {
            return
        }
    }
    
    func removingNumber () -> String {
        
        switch currentState {
        case .begin:
            if amountForDisplay == "" {
                return ""
            } else {
        return amountForDisplay
            }
        case .fillingFirstNumber:
            if firstNumber == "" {
                return ""
            } else {
            amountForDisplay = RemoveNumber.removeLastOne(firstNumber)
            firstNumber = amountForDisplay
            return amountForDisplay
            }
            
        case .fillingSecondNumber:
            if secondNumber == "" {
                return ""
            } else {
            amountForDisplay = RemoveNumber.removeLastOne(secondNumber)
            secondNumber = amountForDisplay
            return amountForDisplay
            }
            
        case .continueCounting:
            return amountForDisplay
            
        default:
            return ""
        }
    }
  
    //    func memory(memoryCommand: CommandForMemory) -> Double {
    //
    //            switch currentState {
    //            case .clean:
    //                 memoryNumber = 0
    //              arithmeticMemoryCommand = .none
    //                  memoryResult = 0
    //                return  memoryResult
    //
    //            case .fillingFirstNumber:
    //                memoryNumber = (firstNumber as NSString).doubleValue
    //                memoryResult = MemoryCount.memoryCounting(memoryNumber, memoryResult: memoryResult, arithmeticMemoryCommand: memoryCommand)
    //                return memoryResult
    //
    //                case .fillingSecondNumber:
    //                result = LogicOfCalulation.calculateResult(firstNumber, secondNumber: secondNumber, arithmeticCommand: arithmeticCommand)
    //                memoryNumber = (result as NSString).doubleValue
    //                memoryResult = MemoryCount.memoryCounting(memoryNumber, memoryResult: memoryResult, arithmeticMemoryCommand: memoryCommand)
    //                currentState = .showingResult
    //                showDisplay()
    //               return memoryResult
    //
    //            case .showingResult:
    //                return memoryResult
    //
    //
    //            default:
    //                return memoryResult
    //
    //
    //        }
    //
    //    }
    
    //    func removeAllMemory() {
    //        memoryNumber = 0
    //        memoryResult = 0
    //        arithmeticMemoryCommand = .none
    //        result = "kiss you!"
    //    }
    //    func showMemoryDisplay() -> String {
    //
    //       var newResult = "\(memoryResult)"
    //      newResult = ShowCorrectResult.correctResult(newResult)
    //
    //            return newResult
    //
    //       
    //    }
}












