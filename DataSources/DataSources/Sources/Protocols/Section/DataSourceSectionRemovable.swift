//
//  DataSourceSectionRemovable.swift
//  SKDataSources
//
//  Created by Sergey on 03.09.2018.
//

import Foundation

public protocol DataSourceSectionRemovable {
    
    func remove(itemsAt indexes: [Int])
    func remove(itemAt index: Int)
    
}
