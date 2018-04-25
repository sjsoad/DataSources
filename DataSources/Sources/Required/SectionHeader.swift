//
//  SectionHeader.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

public class SectionHeader: NSObject {

    private(set) var headerTitle: String?
    private(set) var headerModel: DataSourceModel?
    
    init(with title: String?) {
        self.headerTitle = title
    }
    
    init(with model: DataSourceModel?) {
        self.headerModel = model
    }
    
}
