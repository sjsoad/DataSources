//
//  DataSourceSectionReordering.swift
//  SKDataSources
//
//  Created by Sergey on 03.09.2018.
//

import Foundation


public protocol DataSourceSectionReordering {
    
    func replace<ItemType: DataSourceObjectPresenter>(itemAt index: Int, with item: ItemType)
    func reorderItems(at sourceIndex: Int, and destinationIndex: Int)
    
}
