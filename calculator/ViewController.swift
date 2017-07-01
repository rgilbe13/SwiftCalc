//
//  ViewController.swift
//  calculator
//
//  Created by Rob Gilbert on 6/26/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import UIKit

enum operations {
    case NOT_SET
    case MULTIPLY
    case DIVIDE
    case ADD
    case SUBTRACT
}

class ViewController: UIViewController {
    var labelString:String = "0"
    var operation:operations = operations.NOT_SET
    var savedNum:Double = 0
    var lastButtonWasOperation:Bool = false
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func tappedClear(_ sender: Any) {
        labelString = "0"
        savedNum = 0
        label.text = "0"
        operation = operations.NOT_SET
        lastButtonWasOperation = false
    }
    
    @IBAction func tappedDivide(_ sender: Any) {
        changeOperations(newOperation: operations.DIVIDE)
    }
    
    @IBAction func tappedMultiply(_ sender: Any) {
        changeOperations(newOperation: operations.MULTIPLY)
    }
    
    @IBAction func tappedAdd(_ sender: Any) {
        changeOperations(newOperation: operations.ADD)
    }
    
    @IBAction func tappedSubtract(_ sender: Any) {
        changeOperations(newOperation: operations.SUBTRACT)
    }
    
    @IBAction func tappedEqual(_ sender: Any) {
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
        updateText()
        lastButtonWasOperation = true
    }
    
    @IBAction func tappedNumber(_ sender: UIButton) {
        if lastButtonWasOperation {
            lastButtonWasOperation = false
            labelString = "0"
            updateText()
            
        }
        labelString = labelString.appending((sender.titleLabel?.text)!)
        updateText()
    }
    
    func updateText(){
        guard let labelDouble:Double = Double(labelString) else {
            label.text = "Conversion Failed!"
            return
        }
        if operation == operations.NOT_SET {
            savedNum = labelDouble
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        label.text = numberFormatter.string(from: NSNumber(value:labelDouble))
    }
    
    func changeOperations(newOperation:operations) {
        if savedNum == 0 {
            return
        }
        operation = newOperation
        lastButtonWasOperation = true
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

