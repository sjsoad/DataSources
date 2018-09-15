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
        section = DefaultSection(with: <#T##[CellPresenterRepresentable]#>, header: <#T##SectionHeaderRepresentable?#>, footer: <#T##SectionFooterRepresentable?#>)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}