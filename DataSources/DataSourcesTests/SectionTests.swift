//
//  SectionTests.swift
//  DataSourcesTests
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import XCTest
@testable import DataSources

class SectionTests: XCTestCase {
    
    private var section: SectionRepresentable?
    
    override func setUp() {
        super.setUp()
        section = DefaultSection(with: [TestPresenter()], header: TestHeader(), footer: TestFooter())
    }
    
    override func tearDown() {
        section = nil
        super.tearDown()
    }
    
    func testSetup() {
        XCTAssertEqual(1, section?.itemsCount(), "Invalid count")
        XCTAssertEqual("TestHeader", section?.headerTitle(), "Invalid header title")
        XCTAssertEqual("TestFooter", section?.footerTitle(), "Invalid footer title")
        XCTAssertNotNil(section?.header)
        XCTAssertNotNil(section?.footer)
        XCTAssertNotNil(section?.item(at: 0))
        XCTAssertNil(section?.item(at: 1))
//        func remove(itemsAt indices: [Int])
//        func remove(itemAt index: Int)
//
//        func insert(with newItems: [PresenterType], at index: Int, handler: SectionChangeHandler?)
//        func insert(with item: PresenterType, at index: Int)
//
//        func replace(itemAt index: Int, with item: PresenterType)
//
//        func reorderItems(at sourceIndex: Int, and destinationIndex: Int)
        
    }
    
    func testAppend() {
        section?.append(with: TestPresenter(), handler: { (indices) in
            XCTAssertEqual([1], indices, "Invalid append item")
        })
        section?.append(with: [TestPresenter(), TestPresenter()], handler: { (indices) in
            XCTAssertEqual([2,3], indices, "Invalid append items")
        })
    }
    
}
