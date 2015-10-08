//
//  ViewController.swift
//  Calculator
//
//  Created by Admin on 15.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    var calculatorMethods = Calculator()
    
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        var number = sender.tag
        
        calculatorMethods.sendNumber(number)
    
        result.text = calculatorMethods.showDisplay()
        
    
    }
    
    @IBAction func operatorPressed(sender: UIButton) {
        var operatorTag = sender.tag
      var choosenOperator = CalculationCommand()
        
        if operatorTag == 1001 {
            choosenOperator = .addition
        } else if operatorTag == 1002 {
            choosenOperator = .subtraction
        } else if operatorTag == 1003 {
            choosenOperator = .multiplication
        }else if operatorTag == 1004 {
            choosenOperator = .division
        } else {
            return
        }
        
        calculatorMethods.runCommand(choosenOperator)
        result.text = calculatorMethods.showDisplay()
        //epsilon.text = calculatorMethods.showEpsilon()
        
    }
  
    
    
    @IBAction func equalPressed(sender: UIButton) {
        calculatorMethods.equalResult()
            result.text = calculatorMethods.showDisplay()
        //epsilon.text = calculatorMethods.showEpsilon()
        
    }
    
    
    
    @IBAction func clearPressed(sender: AnyObject) {
        
        calculatorMethods.clearAll()
        label.text = calculatorMethods.showLabel()
        result.text = calculatorMethods.showDisplay()
          }
    
    @IBAction func pointPressed(sender: AnyObject) {
        calculatorMethods.showPoint()
      
      result.text = calculatorMethods.showDisplay()
       
        
    
        
        
        
    }
    
    @IBAction func removePressed(sender: UIButton) {
        calculatorMethods.removingNumber()
        result.text = calculatorMethods.showDisplay()
    }
    

    
    @IBAction func memoryPressed(sender: UIButton) {
   var memoryTag = sender.tag
        var memoryAction = CommandForMemory()
      
        
        if memoryTag == 1010 {
            memoryAction = .plus
        } else if memoryTag == 1011 {
            memoryAction = .minus
        } else if memoryTag == 1012{
            memoryAction = .equalMemory
        } else if memoryTag == 1013 {
            memoryAction = .clean
        } else {
            return
        }
        calculatorMethods.memory(memoryAction)
        label.text = calculatorMethods.showLabel()
        
        result.text = calculatorMethods.showDisplay()
        
        
    }



    
    
}
    


