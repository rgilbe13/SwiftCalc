//
//  ViewController.swift
//  calculator
//
//  Created by Rob Gilbert on 6/26/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let calc = Calculator()
    var operatorCharacterSet: CharacterSet = []
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var pieButton: UIButton!
    @IBOutlet weak var stackView6: UIStackView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var memoryMinus: UIButton!
    @IBOutlet weak var memoryPlus: UIButton!
    @IBOutlet weak var clearEntry: UIButton!
    @IBOutlet weak var tan: UIButton!
    @IBOutlet weak var memoryRecall: UIButton!
    @IBOutlet weak var multiplicativeInverse: UIButton!
    @IBOutlet weak var memoryClear: UIButton!
    
    @IBAction func tappedButton(_ sender: Any) {
        if topLabel.text == "0" {
            topLabel.text = ""
            bottomLabel.text = ""
        }
        
        let inputLabel: String = ((sender as AnyObject).titleLabel??.text)!
        
        if inputLabel == "MP" {
            calc.memoryAdd(value: Double(bottomLabel.text!)!)
        } else if inputLabel == "MM" {
            calc.memoryMinus(value: Double(bottomLabel.text!)!)
        } else if inputLabel == "MC" {
            calc.memoryClear()
        } else if inputLabel == "MR" {
            topLabel.text = calc.memoryRecall()
        }
        
        
        if inputLabel == "CE" && (topLabel.text?.characters.count)! > 0 {
            topLabel.text = topLabel.text?.substring(to: (topLabel.text?.index(before: (topLabel.text?.endIndex)!))!)
        } else if inputLabel == "π" {
            topLabel.text?.append("3.14159")
        } else if inputLabel == "MR" {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            //topLabel.text = numberFormatter.string(from: NSNumber(value:calc.memoryResult))!

        } else if inputLabel == "+/-" {
           
        } else {
            topLabel.text?.append(inputLabel)
        }
        
        if !validateInput(input: topLabel.text! + inputLabel) {
            return
        }

        let x: String = calc.parse(input: (inputLabel))
        let y: String = calc.solve(rpn: x)
        let operators = ["+", "-", "*", "/"]
        //bottomLabel.text = x
        if !operators.contains(inputLabel) {
            bottomLabel.text = y
        }
        
    }
    
    @IBAction func tappedClear(_ sender: Any) {
        calc.clear()
        topLabel.text = "0"
        bottomLabel.text = "0"
    }
    
    @IBAction func tappedEqual(_ sender: Any) {
        topLabel.text = ""
        stackView6.sizeToFit()
    }
    
    func validateInput(input: String) -> Bool {
        // split into tokens and check for multiple periods
        var segmentedInput: String = input.replacingOccurrences(of: "+", with: "|+|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "-", with: "|-|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "*", with: "|*|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "/", with: "|/|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "(", with: "|(|")
        segmentedInput = segmentedInput.replacingOccurrences(of: ")", with: "|)|")
        
        let tokens = segmentedInput.components(separatedBy: "|")
        
        var leftParen: Int = 0
        var rightParen: Int = 0
        for token in tokens {
            if token.components(separatedBy: ".").count-1 > 1 {
                return false
            }
            
            if token == "(" {
                leftParen += 1
            }
            
            if token == ")" {
                rightParen += 1
            }
            
            if rightParen > leftParen {
                return false
            }
            
            
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.accessibilityIdentifier = "MainCalculator"
        bottomLabel.accessibilityIdentifier = "bootomLabel"
        operatorCharacterSet.insert(charactersIn: "+")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            self.pieButton.isHidden = false
            self.memoryMinus.isHidden = false
            self.memoryPlus.isHidden = false
            self.memoryClear.isHidden = false
            self.memoryRecall.isHidden = false
            self.multiplicativeInverse.isHidden = false
            self.tan.isHidden = false
            self.clearEntry.isHidden = false
        } else {
            self.pieButton.isHidden = true
            self.memoryMinus.isHidden = true
            self.memoryPlus.isHidden = true
            self.memoryClear.isHidden = true
            self.memoryRecall.isHidden = true
            self.multiplicativeInverse.isHidden = true
            self.tan.isHidden = true
            self.clearEntry.isHidden = true
            print("Portrait")
        }
    }
    
}

