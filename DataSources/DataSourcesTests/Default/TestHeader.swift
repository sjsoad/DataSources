//
//  TestHeader.swift
//  DataSourcesTests
//
//  Created by Sergey Kostyan on 15.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit
@testable import DataSources

class TestHeader: SectionHeaderRepresentable {

    var headerTitle: String? = "TestHeader"
    
    private(set) var reuseIdentifier: String = "TestHeader"
    
    func set(view: ViewType) {
        print("set view")
    }
    
    func configure() {
        print("configure")
    }

}
