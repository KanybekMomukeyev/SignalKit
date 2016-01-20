//
//  CollectionChangeSetTests.swift
//  SignalKit
//
//  Created by Yanko Dimitrov on 1/20/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import XCTest
@testable import SignalKit

class CollectionChangeSetTests: XCTestCase {

    func testReplacedAllSections() {
        
        var changeSet = CollectionChangeSet()
        
        changeSet.replacedAllSections()
        
        let operations = changeSet.collectionOperations
        
        XCTAssertEqual(operations.contains(.Reset), true, "Should contain the reset operation")
    }
    
    func testInsertedSectionAtIndex() {
        
        var changeSet = CollectionChangeSet()
        
        changeSet.insertedSectionAtIndex(1)
        
        let operations = changeSet.collectionOperations
        let sectionOperations = changeSet.sectionsOperations[1]
        
        XCTAssertEqual(operations.contains(.Insert(index: 1)), true, "Should contain the insert operation")
        XCTAssertEqual(sectionOperations?.isEmpty, true, "Should insert a new section")
    }
    
    func testInsertedSectionAtIndexReturnsIfThereIsResetOperation() {
        
        var changeSet = CollectionChangeSet()
        
        changeSet.replacedAllSections()
        changeSet.insertedSectionAtIndex(0)
        
        let operations = changeSet.collectionOperations
        
        XCTAssertEqual(operations.contains(.Reset), true, "Should return if there is a reset operation in the collection")
        XCTAssertEqual(operations.count, 1, "Should contain only one operations")
    }
    
    func testReplacedAllSectionsRemovesAllPreviousOperations() {
        
        var changeSet = CollectionChangeSet()
        
        changeSet.insertedSectionAtIndex(1)
        changeSet.insertedSectionAtIndex(2)
        changeSet.replacedAllSections()
        
        let operations = changeSet.collectionOperations
        
        XCTAssertEqual(operations.count, 1, "Should contain only one operation")
        XCTAssertEqual(operations.contains(.Reset), true, "Should contain the reset operation")
    }
    
    func testUpdatedSectionAtIndex() {
        
        var changeSet = CollectionChangeSet()
        
        changeSet.updatedSectionAtIndex(2)
        
        let operations = changeSet.collectionOperations
        
        XCTAssertEqual(operations.count, 1, "Should contain only one operation")
        XCTAssertEqual(operations.contains(.Update(index: 2)), true, "Should contain the update operation")
    }
    
    func testUpdatedSectionAtIndexReturnsIfThereIsResetOperation() {
        
        var changeSet = CollectionChangeSet()
        
        changeSet.replacedAllSections()
        changeSet.updatedSectionAtIndex(2)
        
        let operations = changeSet.collectionOperations
        
        XCTAssertEqual(operations.count, 1, "Should contain only one operation")
        XCTAssertEqual(operations.contains(.Reset), true, "Should contain the reset operation")
    }
    
    func testRemovedSectionAtIndex() {
        
        var changeSet = CollectionChangeSet()
        
        changeSet.removedSectionAtIndex(2)
        
        let operations = changeSet.collectionOperations
        
        XCTAssertEqual(operations.count, 1, "Should contain only one operation")
        XCTAssertEqual(operations.contains(.Remove(index: 2)), true, "Should contain the remove operation")
    }
    
    func testRemovedSectionAtIndexReturnsIfThereIsResetOperation() {
        
        var changeSet = CollectionChangeSet()
        
        changeSet.replacedAllSections()
        changeSet.removedSectionAtIndex(22)
        
        let operations = changeSet.collectionOperations
        
        XCTAssertEqual(operations.count, 1, "Should contain only one operation")
        XCTAssertEqual(operations.contains(.Reset), true, "Should contain the reset operation")
    }
    
    func testReplacedItemsInSection() {
        
        var changeSet = CollectionChangeSet()
        
        changeSet.replacedItemsInSection(0)
        
        let operations = changeSet.sectionsOperations
        
        XCTAssert(operations[0] != nil, "Should insert a new set at index 0")
        XCTAssertEqual(operations[0]?.contains(.Reset), true, "Should contain the reset operation")
    }
}
