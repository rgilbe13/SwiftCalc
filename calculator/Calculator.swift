//
//  Calculator.swift
//  calculator
//
//  Created by Rob Gilbert on 7/8/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import Foundation

class Calculator {
    var labelString:String
    var queue:CalcQueue<Character>
    var wasPeriodPressed:Bool
    var lastKeyWasOperation:Bool
    
    init() {
        labelString = "0"
        queue = CalcQueue()
        wasPeriodPressed = false
        lastKeyWasOperation = false
    }
    
    func clear() {
        labelString = "0"
        wasPeriodPressed = false
        queue = CalcQueue()
        lastKeyWasOperation = false
    }
    
    func equal() {
        var calculatedQueue:CalcQueue<Character> = CalcQueue()
        let operators = ["/", "*", "+", "-"]
        var left:String = ""
        var right:String = "
        var op:Character = ""
        var hasParenthesis:Bool = false
        var level1 = true
        var level2 = true
        
        for i in 0...queue.count-1 {
            
            if queue.indexAt(int: i) == "(" && queue.indexAt(int: i+1) == "(" {
                calculatedQueue.push(value: queue.indexAt(int: i))
                hasParenthesis = true
            }
            
            if queue.indexAt(int: i) == "(" && Int(String(queue.indexAt(int: i+1))) != nil {
                for x in i+1...queue.count-1 {
                    if queue.indexAt(int: x) == "." || Int(String(queue.indexAt(int: x))) != nil {
                        left.append(queue.indexAt(int: x))
                    } else if (operators.contains(String(queue.indexAt(int: x))) {
                        op = queue.indexAt(int: x)
                    }
                }
            }
            
        }
        
    }
    
    func addToQueue(char: Character) {
        if lastKeyWasOperation && (char == "/" || char == "*" || char == "+" || char == "-") {
            /// change the operation remove the most recent and push new op on queue
            queue.replaceAt(int: queue.count-1, char: char)
        } else {
            if wasPeriodPressed && char == "." {
                // ignore
            } else {
                queue.push(value: char)
            }
            
        }
        
        if char == "." {
            wasPeriodPressed = true
        }
        
        if char == "/" || char == "*" || char == "+" || char == "-" {
            lastKeyWasOperation = true
            wasPeriodPressed = false
        } else {
            lastKeyWasOperation = false
        }
        
    }
    
    func handleParenthesis() {
        if queue.count == 0 {
            addToQueue(char: "(")
            return
        }
        
        let prevPressedButton: Character = queue.indexAt(int: queue.count-1)
        
        if Int(String(prevPressedButton)) != nil && queue.unmatchedParentesis() {
            addToQueue(char: ")")
        } else if prevPressedButton == "/" || prevPressedButton == "*" || prevPressedButton == "+" || prevPressedButton == "-" {
            addToQueue(char: "(")
        } else if prevPressedButton == "." {
            addToQueue(char: ")")
        } else if prevPressedButton == "(" {
            addToQueue(char: "(")
        } else if prevPressedButton == ")" {
            if queue.unmatchedParentesis() {
                addToQueue(char: ")")
            } else {
                addToQueue(char: "*")
                addToQueue(char: "(")
            }
        }
    }
    
    /// loop through the array and return a string
    func getLabel() -> String {
        var label:String = ""
        for i in 0...queue.count-1  {
            label.append(String(describing: queue.indexAt(int: i)))
        }
        return label
    }
    
}
