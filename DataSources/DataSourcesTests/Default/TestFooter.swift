//
//  TestFooter.swift
//  DataSourcesTests
//
//  Created by Sergey Kostyan on 15.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit
@testable import DataSources

class TestFooter: SectionFooterRepresentable {
    
    var footerTitle: String? = "TestFooter"
    
    private(set) var reuseIdentifier: String = "TestFooter"
    
    func set(view: ViewType) {
        print("set view")
    }
    
    func configure() {
        print("configure")
    }
    
}
