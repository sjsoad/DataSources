//
//  DataSourceRepresentable.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import Foundation

public protocol DataSourceRepresentable {

    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item<PresenterType>(at indexPath: IndexPath) -> PresenterType?
    
}
