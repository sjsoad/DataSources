//
//  DataSourceRemovable.swift
//  SKDataSources
//
//  Created by Sergey on 03.09.2018.
//

import Foundation

public protocol DataSourceRemovable {
    
    func remove(itemsAt indexPathes: [IndexPath])
    func remove(itemAt indexPath: IndexPath)
    
    // These methods lead to a mutation of the array of sections, so implemented in "View type"ArrayDataSource
    func remove(sectionsAt indexes: [Int])
    func remove(sectionAt index: Int)
    
}
