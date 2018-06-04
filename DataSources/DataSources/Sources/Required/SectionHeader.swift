//
//  SectionHeader.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

open class SectionHeader: NSObject {

    private(set) var headerTitle: String?
    private(set) var headerModel: DataSourceObjectPresenter?
    
    init(with title: String?) {
        self.headerTitle = title
    }
    
    init(with model: DataSourceObjectPresenter?) {
        self.headerModel = model
    }
    
}
