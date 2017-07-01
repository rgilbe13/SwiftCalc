//
//  ViewController.swift
//  calculator
//
//  Created by Rob Gilbert on 6/26/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import UIKit

class Calculator {
    enum operations {
        case NOT_SET
        case MULTIPLY
        case DIVIDE
        case ADD
        case SUBTRACT
    }
    
    var labelString:String = "0"
    var operation:operations = operations.NOT_SET
    var savedNum:Double = 0
    var lastButtonWasOperation:Bool = false
    
    func updateText() -> String {
        guard let labelDouble:Double = Double(labelString) else {
            return "Conversion Failed!"
        }
        if operation == operations.NOT_SET {
            savedNum = labelDouble
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:labelDouble))!
    }
    
    func changeOperations(newOperation:operations) {
        if savedNum == 0 {
            return
        }
        operation = newOperation
        lastButtonWasOperation = true
    }
    
    func clear() {
        labelString = "0"
        savedNum = 0
        operation = operations.NOT_SET
        lastButtonWasOperation = false
    }
    
    func equal() {
        guard let num:Double = Double(labelString) else {
            return
        }
        if operation == operations.NOT_SET || lastButtonWasOperation {
            return
        }
        if operation == operations.ADD {
            savedNum += num
        } else if operation == operations.SUBTRACT {
            savedNum -= num
        } else if operation == operations.MULTIPLY {
            savedNum *= num
        } else if operation == operations.DIVIDE {
            savedNum /= num
        }
        operation = operations.NOT_SET
        labelString = "\(savedNum)"
        lastButtonWasOperation = true
    }
    
    func number(num: String) {
        if lastButtonWasOperation {
            lastButtonWasOperation = false
            labelString = "0"
        }
        labelString = labelString.appending(num)
    }
    
}



class ViewController: UIViewController {
    let calc = Calculator()
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func tappedClear(_ sender: Any) {
        calc.clear()
        label.text = "0"
    }
    
    @IBAction func tappedDivide(_ sender: Any) {
        calc.changeOperations(newOperation: Calculator.operations.DIVIDE)
    }
    
    @IBAction func tappedMultiply(_ sender: Any) {
        calc.changeOperations(newOperation: Calculator.operations.MULTIPLY)
    }
    
    @IBAction func tappedAdd(_ sender: Any) {
        calc.changeOperations(newOperation: Calculator.operations.ADD)
    }
    
    @IBAction func tappedSubtract(_ sender: Any) {
        calc.changeOperations(newOperation: Calculator.operations.SUBTRACT)
    }
    
    @IBAction func tappedEqual(_ sender: Any) {
        calc.equal()
        label.text = calc.updateText()
    }
    
    @IBAction func tappedNumber(_ sender: UIButton) {
        calc.number(num: (sender.titleLabel?.text)!)
        label.text = calc.updateText()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

