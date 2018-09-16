//
//  SectionAppendTests.swift
//  DataSourcesTests
//
//  Created by Sergey Kostyan on 16.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import XCTest
@testable import DataSources
class SectionAppendTests: XCTestCase {

    private var section: SectionRepresentable?
    
    override func setUp() {
        super.setUp()
        section = DefaultSection(with: [], header: nil, footer: nil)
        countTest(0)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func countTest(_ validCount: Int){
        XCTAssertEqual(validCount, section?.itemsCount(), "Invalid count")
    }
    
    func testAppend() {
        section?.append(with: TestPresenter(), handler: { [weak self] (indices) in
            XCTAssertEqual([0], indices, "Invalid append item")
            self?.countTest(1)
        })
        section?.append(with: [TestPresenter(), TestPresenter()], handler: { [weak self] (indices) in
            XCTAssertEqual([1,2], indices, "Invalid append items")
            self?.countTest(3)
        })
        section?.append(with: [], handler: { (indices) in
            XCTFail("handler should not be caled while appending with empty array")
        })
    }

}
