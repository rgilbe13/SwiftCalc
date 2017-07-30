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
        let result: String = calc!.parse(input: "5+5")
        XCTAssert(result == "5|5|+")
    }
    
    func testComplexParse() {
        let result: String = calc!.parse(input: "5+5*(2+3)/2+(10)-(2.5+5)")
        XCTAssert(result == "5|5|2|3|+|2|/|*|10|2.5|5|+|-|+|+")
    }
    
    func testMemoryFunctions() {
        var result: String = calc!.parse(input: "55MP")

        print(result)
        print(calc?.memoryResult)
        XCTAssert(calc?.memoryResult == 55)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

public struct mockQueue: PCalculatorQueue {
    var elements = ["5", "5"]
    var isEmpty: Bool { return elements.isEmpty }
    
    mutating func enqueue(newElement: String) {
        elements.append(newElement)
    }
    
    mutating func dequeue() -> String {
        return elements.removeFirst()
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
}
