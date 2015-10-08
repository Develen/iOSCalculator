//
//  Calculator.swift
//  Calculator
//
//  Created by Admin on 19.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation

public class Calculator {
    //5M+  + 6 M- + 3M+ MR = 8
    private var firstNumber = ""
    private var secondNumber = ""
    private var amountForDisplay = ""
    private var arithmeticCommand = CalculationCommand()
    private var currentState = CurrentState()
    private var resultAsFirstNumber: Double = 0
    private var point = false
    private var memory = Memory()
//    private var memoryNumber: Double = 0
//    private var memoryResult: Double = 0
//    private var arithmeticMemoryCommand = CommandForMemory()
 
    public init() {
        
    }
   
    public func clearAll () {
        firstNumber = ""
        secondNumber = ""
        arithmeticCommand = .none
        currentState = .begin
        resultAsFirstNumber = 0
        amountForDisplay = ""
        point = false
        memory.cleanAllMemory()
//        memoryNumber = 0
//        memoryResult = 0
//        arithmeticMemoryCommand = .none
    }
    
    public func sendNumber(number: Int) {
        
        if number > CalculatorConstants.maxNumberOfButton || number < CalculatorConstants.minNumberOfButton {
            return
        }
        
        switch currentState {
        case .begin:
            firstNumber = "\(number)"
            amountForDisplay = firstNumber
            secondNumber = ""
            currentState = .fillingFirstNumber
            resultAsFirstNumber = (firstNumber as NSString).doubleValue
            
            
        case .fillingFirstNumber:
            if firstNumber == "0" {
                firstNumber = "\(number)"
                amountForDisplay = firstNumber
            } else {
                firstNumber = LimitForDispaly.limitDisplay(firstNumber, number: number, maxLength: CalculatorConstants.maxLengthForNumber)
                amountForDisplay = firstNumber
            }
            
        case .fillingSecondNumber:
            if secondNumber == "0" {
                secondNumber = "\(number)"
                amountForDisplay = secondNumber
            } else {
                secondNumber = LimitForDispaly.limitDisplay(secondNumber, number: number, maxLength: CalculatorConstants.maxLengthForNumber)
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
            return //TODO: use exceptions
        }
        
    }
    
    public func runCommand(calculationCommand: CalculationCommand) {
        
        switch currentState {
        case .begin:
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                arithmeticCommand = calculationCommand
                currentState = .continueCounting
                
            default:
                return //TODO: use exceptions
                
            }
            
        case .fillingFirstNumber:
            resultAsFirstNumber = (firstNumber as NSString).doubleValue
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                arithmeticCommand = calculationCommand
                currentState = .fillingSecondNumber
                point = false
                
            default:
                return //TODO: use exceptions
            }
            
        case .fillingSecondNumber:
            
            switch calculationCommand {
            case .addition, .subtraction, .multiplication, .division:
                if secondNumber == "" {
                    arithmeticCommand = calculationCommand
                    currentState = .continueCounting
                } else {
               
                resultAsFirstNumber = LogicOfCalulation.calculateResult(resultAsFirstNumber, secondNumber: secondNumber, arithmeticCommand: arithmeticCommand)
                arithmeticCommand = calculationCommand
                currentState = .continueCounting
                amountForDisplay = "\(resultAsFirstNumber)"
                point = false
                }
               
                
            default:
                return //TODO: use exceptions
            }
            
        case .continueCounting:
            
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
            if secondNumber == "" {
            currentState = .begin
                arithmeticCommand = .none
            } else {
            
            resultAsFirstNumber = LogicOfCalulation.calculateResult(resultAsFirstNumber, secondNumber: secondNumber, arithmeticCommand: arithmeticCommand)
            amountForDisplay = "\(resultAsFirstNumber)"
            currentState = .begin
            point = false
            }
        case .continueCounting:
            currentState = .begin
            arithmeticCommand = .none
        }
    }
    
    // if static so problem with current state
    public func showDisplay() -> String {
        
             
        switch currentState {
        case .begin:
            if firstNumber == "" {
                return ""
            } else {
                return ShowCorrectResult.showLimitingResult(resultAsFirstNumber, maxLength: CalculatorConstants.maxLengthForDisplay)
               
            }
            
        case .fillingFirstNumber:
            return amountForDisplay
            
        case .fillingSecondNumber:
            return amountForDisplay
            
        case .continueCounting:
            return ShowCorrectResult.showLimitingResult(resultAsFirstNumber, maxLength: CalculatorConstants.maxLengthForDisplay)
        
        default:
            return ""
        }
    }
    
    public func showPoint() {
        
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
    
    public func removingNumber () {
        
        switch currentState {
        case .begin:
            return
            

        case .fillingFirstNumber:
            if firstNumber == "" {
                return
            } else {
            amountForDisplay = RemoveNumber.removeLastOne(firstNumber)
            firstNumber = amountForDisplay
            
            }
            
        case .fillingSecondNumber:
            if secondNumber == "" {
                return
            } else {
            amountForDisplay = RemoveNumber.removeLastOne(secondNumber)
            secondNumber = amountForDisplay
          
            }
            
        case .continueCounting:
            
//            if amountForDisplay == "" {
//                return
//            } else {
//                amountForDisplay = RemoveNumber.removeLastOne(amountForDisplay)
//                firstNumber = amountForDisplay
//                resultAsFirstNumber = (amountForDisplay as NSString).doubleValue
//            }
//            
         return
            
        default:
            return
        }
    }
  
       public func memory(memoryCommand: CommandForMemory) {
   
        var currentNumber = 0.0
        
        switch currentState {
        case .begin:
            currentNumber = resultAsFirstNumber
        case .fillingFirstNumber:
            currentNumber = (amountForDisplay as NSString).doubleValue
        case .fillingSecondNumber:
            currentNumber = (amountForDisplay as NSString).doubleValue
        case .continueCounting:
         currentNumber = resultAsFirstNumber
        default: return
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
            amountForDisplay = "\(memory.equalMemory())"
             case .fillingFirstNumber:
            currentState = .begin
            case .fillingSecondNumber:
            resultAsFirstNumber = memory.equalMemory()
             currentState = .begin
            case .continueCounting:
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
//             switch currentState {
//               case .begin:
//
//                    memoryNumber = resultAsFirstNumber
//                 //arithmeticMemoryCommand = memoryCommand
//                     memoryResult = MemoryCount.memoryCounting(memoryNumber, memoryResult: memoryResult, arithmeticMemoryCommand: memoryCommand)
//                   amountForDisplay = "\(memoryResult)"
//                   
//               case .fillingFirstNumber:
//                   memoryNumber = (amountForDisplay as NSString).doubleValue
//                   memoryResult = MemoryCount.memoryCounting(memoryNumber, memoryResult: memoryResult, arithmeticMemoryCommand: memoryCommand)
//                   currentState = .begin
//                  
//               case .fillingSecondNumber:
//                   memoryNumber = LogicOfCalulation.calculateResult(resultAsFirstNumber, secondNumber: secondNumber, arithmeticCommand: arithmeticCommand)
//                   resultAsFirstNumber = memoryNumber
//                      memoryResult = MemoryCount.memoryCounting(memoryNumber, memoryResult: memoryResult, arithmeticMemoryCommand: memoryCommand)
//               
//                   currentState = .begin
//                   
//                 
//                
//   
//               case .continueCounting:
//               memoryNumber = resultAsFirstNumber
//                    memoryResult = MemoryCount.memoryCounting(memoryNumber, memoryResult: memoryResult, arithmeticMemoryCommand: memoryCommand)
//                   currentState = .begin
//   
//   
//               default:
//                   return 
   
   
//           }
//   
//       }
//   
//       public func cleanAllMemory() {
//           memoryNumber = 0
//           memoryResult = 0
//           arithmeticMemoryCommand = .none
//          
//       }
//       public func showMemoryDisplay() -> String {
//           resultAsFirstNumber = memoryResult
//   
//       return ShowCorrectResult.showLimitingResult(resultAsFirstNumber, maxLength: 13)
//   
//          
//       }
//    
//
//    public func showLabel() -> String {
//        if memoryResult != 0 {
//            return "M"
//        }else {
//            return ""
//        }
//    }
}












