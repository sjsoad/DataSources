//
//  SectionFooter.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

open class SectionFooter: NSObject {

    private(set) var footerTitle: String?
    private(set) var footerModel: DataSourceObjectPresenter?
    
    init(with title: String?) {
        self.footerTitle = title
    }
    
    init(with model: DataSourceObjectPresenter?) {
        self.footerModel = model
    }
    
}
