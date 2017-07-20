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
    

    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBAction func tappedButton(_ sender: Any) {
        if topLabel.text == "0" {
            topLabel.text = ""
            bottomLabel.text = ""
        }
        
        let inputLabel: String = ((sender as AnyObject).titleLabel??.text)!
        
        if !validateInput(input: topLabel.text! + inputLabel) {
            return
        }

        topLabel.text?.append(inputLabel)
        let x: String = calc.parse(input: (topLabel.text)!)
        let y: String = calc.solve(rpn: x)
        let operators = ["+", "-", "*", "/"]
        if !operators.contains(inputLabel) {
            bottomLabel.text = y
        }
        
    }
    
    @IBAction func tappedClear(_ sender: Any) {
        topLabel.text = "0"
        bottomLabel.text = "0"
    }
    
    @IBAction func tappedEqual(_ sender: Any) {
        topLabel.text = ""
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

