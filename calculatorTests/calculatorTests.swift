//
//  calculatorTests.swift
//  calculatorTests
//
//  Created by Rob Gilbert on 6/26/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import XCTest
@testable import calculator

class calculatorTests: XCTestCase {
    var calc: Calculator?
    
    override func setUp() {
        super.setUp()
        calc = Calculator()
    }
    
    override func tearDown() {
        calc = nil
        super.tearDown()
    }
    
    func testAdditionOperator() {
        let result: String = (calc?.solve(rpn: "5|5|+"))!
        XCTAssert(result == "10")
        
    }
    
    func testSubtractionOperator() {
        let result: String = (calc?.solve(rpn: "20|10|-"))!
        XCTAssert(result == "10")
    }
    
    func testMultiplicationOperator() {
        let result: String = (calc?.solve(rpn: "10|10|*"))!
        XCTAssert(result == "100")
    }
    
    func testDivionOperator() {
        let result: String = (calc?.solve(rpn: "10|2|/"))!
        XCTAssert(result == "5")
    }
    
    func testParse() {
        calc!.parse(input: "5")
        calc!.parse(input: "+")
        let result: String = calc!.parse(input: "5")
        print("my resulst \(result)")
        XCTAssert(result == "5|5|+")
    }
    
    func testParseWithSolve() {
        calc!.parse(input: "5")
        calc!.parse(input: "+")
        let result: String = calc!.parse(input: "5")
        print("my resulst \(result)")
        XCTAssert(result == "5|5|+")
        XCTAssert(calc?.solve(rpn: result) == "10")
    }
    
    func testComplexParse() {
        calc!.parse(input: "5")
        calc!.parse(input: "+")
        calc!.parse(input: "5")
        calc!.parse(input: "*")
        calc!.parse(input: "(")
        calc!.parse(input: "2")
        calc!.parse(input: "+")
        calc!.parse(input: "3")
        calc!.parse(input: ")")
        calc!.parse(input: "/")
        calc!.parse(input: "2")
        calc!.parse(input: "+")
        calc!.parse(input: "(")
        calc!.parse(input: "10")
        calc!.parse(input: ")")
        calc!.parse(input: "-")
        calc!.parse(input: "(")
        calc!.parse(input: "2.5")
        calc!.parse(input: "+")
        calc!.parse(input: "5")
        let result: String = calc!.parse(input: ")")
        print("my resulst \(result)")
        XCTAssert(result == "5|5|2|3|+|*|2|/|+|10|+|2.5|5|+|-")
    }
    
    func testMemoryFunctions() {
        calc?.memoryAdd(value: 20)
        calc?.memoryMinus(value: 10)
        XCTAssert(calc?.memoryRecall() == "10")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

struct mockQueue: PCalculatorQueue {
    var elements = ["5", "5"]
    var isEmpty: Bool { return elements.isEmpty }
    
    mutating func enqueue(newElement: String) {
        elements.append(newElement)
    }
    
    mutating func dequeue() -> String {
        return elements.removeFirst()
    }
    
    mutating func clear() {
        elements.removeAll()
    }
    
    mutating func top() -> String {
        return elements.last!
    }
}

struct mockStack: PCalculatorStack {
    private var elements = ["+"]
    var isEmpty: Bool { return elements.isEmpty }
    
    mutating func push(newElement: String) {
        elements.append(newElement)
    }
    
    mutating func pop() -> String {
        return elements.removeLast()
    }
    
    mutating func top() -> String {
        return elements.last!
    }
    
    mutating func count() -> Int {
        return elements.count
    }
    
    mutating func clear() {
        elements.removeAll()
    }
}
