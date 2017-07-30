//
//  Calculator.swift
//  calculator
//
//  Created by Rob Gilbert on 7/8/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import Foundation

class Calculator {
    var mainStack = Stack()
    var mainOutput = Queue()
    var lastNumber: String
    
    var operators: [String: Int] = ["*": 3, "/": 3, "+": 2, "-": 2, "tan": 4, "+/-": 3]
    
    func parse(input: String) -> String {
        var stack = Stack()
        var output = Queue()
        var segmentedInput: String = input.replacingOccurrences(of: "+", with: "|+|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "-", with: "|-|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "*", with: "|*|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "/", with: "|/|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "(", with: "|(|")
        segmentedInput = segmentedInput.replacingOccurrences(of: ")", with: "|)|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "MP", with: "|MP|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "MM", with: "|MM|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "MC", with: "|MC|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "MR", with: "|MR|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "tan", with: "|tan|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "+/-", with: "|+/-|")
        
        let tokens = segmentedInput.components(separatedBy: "|")
        
        for token in tokens {
            // if token is a number add to queue
            if  token.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil{
                output.enqueue(newElement: token)
                lastNumber = token
            //if token is an operator
            } else if isOperator(op: token) {
                // if the stack has lower operators then pop them to the queue
                while !stack.isEmpty && isOperator(op: stack.top()) && operators[stack.top()]! > operators[token]! {
                    output.enqueue(newElement: stack.pop())
                }
                //push new token to stack
                stack.push(newElement: token)
                
            } else if token == "(" {
                stack.push(newElement: token)
            } else if token == ")" {
                // until the token on the stack is the left most parenthesis
                while !stack.isEmpty && stack.top() != "(" {
                    output.enqueue(newElement: stack.pop())
                }
                
                if stack.isEmpty {
                    return "Error"
                }
                
                // get rid of the left paren from stack
                stack.pop()
            }
        }
        
        while !stack.isEmpty && isOperator(op: stack.top()) {
            output.enqueue(newElement: stack.pop())
        }
        
        mainStack = stack
        mainOutput = output
        
        return output.elements.joined(separator: "|")
    }
    
    func isOperator(op: String) -> Bool {
        var isOp: Bool = false
        for (key,_) in operators {
            if key == op {
                isOp = true
            }
        }
        
        return isOp
    }
    
    func solve(rpn: String) -> String {
        var stack = Stack()
        let tokens = rpn.components(separatedBy: "|")
        var result: Double = 0.0
        
        for token in tokens {
            // if token is a number add to queue
            if  token.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil{
                stack.push(newElement: token)
                //if token is an operator
            } else if token == "tan" && !stack.isEmpty {
                result = tan(Double(stack.pop())!)
                stack.push(newElement: DoubletoString(num: result))
            }else if isOperator(op: token) && stack.count() > 1 {
                guard let rightOperand:Double = Double(stack.pop()) else {
                    return "Failed"
                }
                guard let leftOperand:Double = Double(stack.pop()) else {
                    return "Failed"
                }
                
                if token == "+" {
                    result = leftOperand + rightOperand
                } else if token == "-" {
                    result = leftOperand - rightOperand
                } else if token == "*" {
                    result = leftOperand * rightOperand
                } else if token == "/" {
                    result = leftOperand / rightOperand
                }
                
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = NumberFormatter.Style.decimal
                let stringResult:String = numberFormatter.string(from: NSNumber(value:result))!

                stack.push(newElement: stringResult)
            }
        }
        
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:result))!
    }
    
    func DoubletoString(num: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:num))!
    }
    
    func lastNumber() -> String {
        return lastNumber
    }
    
}
