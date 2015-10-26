//
//  ShowCorrectResult.swift
//  Calculator
//
//  Created by Admin on 25.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//
/* public dlya drugih proektov  v testi i td
class = static dlya classa eto mogu v drugih failah bez init srazu mogu visivat
private eto opposit dlya public tolko vnutri etogo classa
*/
import Foundation

public class ShowCorrectResult {
    
    private static let minLengthForStringResult = 6
   
    
    public static func showLimitingResult (resultAsFirstNumber : Double, maxLength: Int) ->  String {
        if maxLength < minLengthForStringResult           //|| maxLength > CalculatorConstants.maxLengthForDisplay
        {
            return "incorrect max length of display"
        } else {
        
        let formatter = NSNumberFormatter()
        formatter.decimalSeparator = "."
        
        if resultAsFirstNumber < 1 && resultAsFirstNumber > 0 {
            
            let power = maxLength - 2
            var resultForCountingEpsilonDisplay = resultAsFirstNumber
            
            if resultAsFirstNumber < ((1) / pow(10, Double(power))) {
                var counting = 0
                while resultForCountingEpsilonDisplay < 1 {
                    resultForCountingEpsilonDisplay = resultForCountingEpsilonDisplay * 10
                    
                    counting++
                }
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 1
                return formatter.stringFromNumber(resultForCountingEpsilonDisplay)! + "E-" + "\(counting)"
                
            } else {
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = maxLength - 2
                return "0" + formatter.stringFromNumber(resultAsFirstNumber)!
                
            }

        
        }
        else if resultAsFirstNumber > -1 && resultAsFirstNumber < 0 && resultAsFirstNumber != -0 {
            
            
            let power = maxLength - 3
            var resultForCountingEpsilonDisplay = resultAsFirstNumber
            
            if resultAsFirstNumber > ((-1) / pow(10, Double(power))) {
                var counting = 0
                while resultForCountingEpsilonDisplay > -1 {
                   resultForCountingEpsilonDisplay = resultForCountingEpsilonDisplay * 10
                    
                    counting++
                }
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 1
                return formatter.stringFromNumber(resultForCountingEpsilonDisplay)! + "E-" + "\(counting)"

            } else {
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = maxLength - 3
                return "-0" + formatter.stringFromNumber(resultAsFirstNumber * (-1))!
            
            }
            
        }
    
        else if resultAsFirstNumber >= 1 || resultAsFirstNumber <= -1  {
            if resultAsFirstNumber <= Double(Int64.max) {
                let integerFromResultAsFirstNumber = Int64(resultAsFirstNumber)
                let countingIntegerFromResultAsFirstNumber = "\(integerFromResultAsFirstNumber)".characters.count
                
            if countingIntegerFromResultAsFirstNumber < (maxLength - 1) {
                
                formatter.minimumSignificantDigits = 0
                if resultAsFirstNumber > 1 {
                    formatter.maximumSignificantDigits = (maxLength - 1)
                } else {
                    formatter.maximumSignificantDigits = (maxLength - 2)
                }
                return formatter.stringFromNumber(resultAsFirstNumber)!
                
            } else if countingIntegerFromResultAsFirstNumber > maxLength && integerFromResultAsFirstNumber <= Int64.max {
                return largeAmountForDisplay(integerFromResultAsFirstNumber, maxLength: maxLength)
                
            } else if countingIntegerFromResultAsFirstNumber == maxLength || countingIntegerFromResultAsFirstNumber == (maxLength - 1) {
                              return formatter.stringFromNumber(resultAsFirstNumber)!
                
            } else {
                return "wrong number"
            }
            }
        }

            else if resultAsFirstNumber == -0 || resultAsFirstNumber == 0 {
                return "0"
                
            } else {
            return "incorrect result"
            }
        }
     
            return "large number"
        
      }
    



    init () {
        
    }
    
    private class func largeAmountForDisplay (integerFromDoubleResult: Int64, maxLength: Int ) -> String {
        
        let countingIntegerFromDoubleResult = "\(integerFromDoubleResult)".characters.count
        var power = 1
        if integerFromDoubleResult > 0 {
            power = countingIntegerFromDoubleResult - 1
        } else {
            power = countingIntegerFromDoubleResult - 2
        }
        
        let resultForDisplay = Double(integerFromDoubleResult) / pow(10, Double(power))
        let countingPower = "\(power)".characters.count
        let formatter = NSNumberFormatter()
        
        if integerFromDoubleResult > 0 {
            formatter.minimumSignificantDigits = (maxLength - countingPower - 3)
            // 3 is for plus, point and E
        } else {
            formatter.minimumSignificantDigits = (maxLength - countingPower - 4)
        }
        formatter.maximumSignificantDigits = formatter.minimumSignificantDigits
        return formatter.stringFromNumber(resultForDisplay)! + "E+" + "\(power)"
    }
    
}
