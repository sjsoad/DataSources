//
//  SectionFooterPresenter.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

public protocol SectionFooterPresenter: DataSourceObjectPresenter {

    var footerTitle: String? { get }
    
}
