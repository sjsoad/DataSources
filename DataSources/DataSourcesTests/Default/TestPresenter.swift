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

    private(set) var reuseIdentifier: String
    
    init(with reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }
    
    func set(view: UIView) {
        print("set view called")
    }
    
}
