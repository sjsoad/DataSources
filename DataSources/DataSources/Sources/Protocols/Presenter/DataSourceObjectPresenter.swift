//
//  DataSourceObjectPresenter.swift
//  DataSources
//
//  Created by Sergey Kostyan on 03.06.2018.
//Copyright © 2018 Sergey. All rights reserved.
//

import UIKit
import Foundation

public protocol DataSourceObjectPresenter: Configurable {
    
    var reuseIdentifier: String { get }
    func set(view: UIView)
    
}
