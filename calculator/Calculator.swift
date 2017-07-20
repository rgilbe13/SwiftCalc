//
//  Calculator.swift
//  calculator
//
//  Created by Rob Gilbert on 7/8/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import Foundation

class Calculator {
    var operators: [String: Int] = ["*": 3, "/": 3, "+": 2, "-": 2]
    
    func parse(input: String) -> String {
        var stack = Stack<String>()
        var output = Queue<String>()
        
        var segmentedInput: String = input.replacingOccurrences(of: "+", with: "|+|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "-", with: "|-|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "*", with: "|*|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "/", with: "|/|")
        segmentedInput = segmentedInput.replacingOccurrences(of: "(", with: "|(|")
        segmentedInput = segmentedInput.replacingOccurrences(of: ")", with: "|)|")
        
        let tokens = segmentedInput.components(separatedBy: "|")
        
        for token in tokens {
            // if token is a number add to queue
            if  token.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil{
                output.enqueue(newElement: token)
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
        var stack = Stack<String>()
        let tokens = rpn.components(separatedBy: "|")
        var result: Double = 0.0
        
        for token in tokens {
            // if token is a number add to queue
            if  token.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil{
                stack.push(newElement: token)
                //if token is an operator
            } else if isOperator(op: token) && stack.count() > 1 {
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
    
}
