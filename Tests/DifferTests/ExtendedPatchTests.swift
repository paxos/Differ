//
//  ExtendedPatchTests.swift
//  DifferTests
//
//  Created by Patrick Dinger on 2/6/22.
//  Copyright © 2022 Differ Project. All rights reserved.
//

import XCTest
import Differ

class ExtendedPatchTests: XCTestCase {
    func testDifferScenario1() throws {
        let input  = [1, 3, 4]
        let output = [1, 2, 3, 4]
        let result = runDiffer(start: input, end: output)
        XCTAssertEqual(output, result)
    }
    
    func testDifferScenario2() throws {
        let input  = [1, 2, 3, 4]
        let output = [1, 3, 4]
        let result = runDiffer(start: input, end: output)
        XCTAssertEqual(output, result)
    }
    
    func testDifferScenario3() throws {
        let input  = [1, 2, 3, 4]
        let output = [4, 3, 2, 1]
        let result = runDiffer(start: input, end: output)
        XCTAssertEqual(output, result)
    }
    
    /// This fails: Thread 1: Fatal error: Index out of range
    /// MOVE number from 8 4 [4, 4, 3, 8, 2, 5, 6, 9]
    /// The array is only 8 elements long, not 9
    func testDifferScenarioFailure() throws {
        let input  = [7, 2, 5, 6, 9]
        let output = [4, 4, 3, 8, 9, 5, 2, 5]
        let result = runDiffer(start: input, end: output)
        XCTAssertEqual(output, result)
    }
    
    /// This is another example of a failed scenario
    func testDifferScenarioFailure_alternative() throws {
        let input  = [9, 0, 10, 5]
        let output = [1, 2, 7, 5, 6, 5, 10, 6, 9, 10]
        let result = runDiffer(start: input, end: output)
        XCTAssertEqual(output, result)
    }
    
    func testDifferScenario5() throws {
        let input  = [7, 2, 5, 6, 9]
        let output = [4, 4, 3, 8, 9, 5, 2, 5]
        let result = runDiffer(start: input, end: output)
        XCTAssertEqual(output, result)
    }
}

private func runDiffer<T: Equatable>(start: [T], end: [T]) -> [T] {
    let patches = Differ.extendedPatch(from: start, to: end)
    var workingSet = start

    for patch in patches {
        switch patch {
        case .insertion(index: let index, element: let element):
            print("INSERT \(element) at", index)
            workingSet.insert(element, at: index)
            print(workingSet)
        case .deletion(index: let index):
            print("REMOVE \(workingSet[index]) at", index)
            workingSet.remove(at: index)
            print(workingSet)
        case .move(from: let from, to: let to):
            print("MOVE number from", from, to, workingSet)
            let val = workingSet[from]
            print(val)
            workingSet.remove(at: from)
            workingSet.insert(val, at: to)
            print(workingSet)
        }
    }

    return workingSet
}
