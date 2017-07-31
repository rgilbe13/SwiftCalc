//
//  Calculator.swift
//  calculator
//
//  Created by Rob Gilbert on 7/8/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import Foundation

class Calculator {
    var stack = Stack()
    var rpnOutput = Queue()
    var standardOutput = Queue()
    var tokens = [String]()
    var memory:Double = 0
    
    var operators: [String: Int] = ["*": 3, "/": 3, "+": 2, "-": 2, "tan": 4, "+/-": 4]
    
    func parse(input: String) -> String {
        tokens.removeAll()
        rpnOutput.clear()
        
        if input == "+/-" {
            var lastToken: String = standardOutput.top()
            if lastToken.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
                standardOutput.dequeue()
                standardOutput.enqueue(newElement: "(")
                standardOutput.enqueue(newElement: "0")
                standardOutput.enqueue(newElement: "-")
                standardOutput.enqueue(newElement: lastToken)
                standardOutput.enqueue(newElement: ")")
            }
            print(lastToken)
        }
        
        while !standardOutput.isEmpty {
            tokens.append(standardOutput.dequeue())
        }
        tokens.append(input)
        
        for token in tokens {
            standardOutput.enqueue(newElement: token)
            // if token is a number add to queue
            if  token.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil{
                rpnOutput.enqueue(newElement: token)
            //if token is an operator
            } else if isOperator(op: token) {
                // if the stack has greater than or equal operators then pop them to the queue
                while !stack.isEmpty && isOperator(op: stack.top()) && operators[stack.top()]! >= operators[token]! {
                    rpnOutput.enqueue(newElement: stack.pop())
                }
                //push new token to stack
                stack.push(newElement: token)
                
            } else if token == "(" {
                stack.push(newElement: token)
            } else if token == ")" {
                // until the token on the stack is the left most parenthesis
                while !stack.isEmpty && stack.top() != "(" {
                    rpnOutput.enqueue(newElement: stack.pop())
                }
                
                if stack.isEmpty {
                    return "Error"
                }
                
                // get rid of the left paren from stack
                stack.pop()
            }
        }
        
        while !stack.isEmpty && isOperator(op: stack.top()) {
            rpnOutput.enqueue(newElement: stack.pop())
        }
        
        return rpnOutput.elements.joined(separator: "|")
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
        var solveStack = Stack()
        let tokens = rpn.components(separatedBy: "|")
        var result: Double = 0.0
        var test:String = ""
        
        for token in tokens {
            // if token is a number add to stack
            if  token.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil{
                solveStack.push(newElement: token)
                //if token is an operator
            } else if token == "tan" && !solveStack.isEmpty {
                result = tan(Double(solveStack.pop())!)
                solveStack.push(newElement: DoubletoString(num: result))
            }else if isOperator(op: token) && solveStack.count() > 1 {
                guard let rightOperand:Double = Double(solveStack.pop()) else {
                    return "Failed"
                }
                guard let leftOperand:Double = Double(solveStack.pop()) else {
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
                test.append("\(leftOperand) \(token) \(rightOperand)")
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = NumberFormatter.Style.decimal
                let stringResult:String = numberFormatter.string(from: NSNumber(value:result))!

                solveStack.push(newElement: stringResult)
            }
        }
        
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:result))!
    }
    
    func clear() {
        stack.clear()
        rpnOutput.clear()
        standardOutput.clear()
    }
    
    
    func DoubletoString(num: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:num))!
    }
    
    func memoryAdd(value: Double) {
        memory += value
    }
    
    func memoryMinus(value: Double) {
        memory -= value
    }
    
    func memoryRecall() -> String {
        return DoubletoString(num: memory)
    }
    
    func memoryClear() {
        memory = 0
    }
}
