//
//  TestPresenter.swift
//  DataSourcesTests
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit
@testable import DataSources

class TestPresenter: PresenterType {
    
    private(set) var reuseIdentifier: String = "TestPresenter"
    
    func set(view: ViewType) {
        print("set view")
    }
    
    func configure() {
        print("configure")
    }
}
