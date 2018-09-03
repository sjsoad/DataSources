//
//  DataSourceSectionInsertable.swift
//  SKDataSources
//
//  Created by Sergey on 03.09.2018.
//

import Foundation

public protocol DataSourceSectionInsertable {
    
    func insert<ItemType: DataSourceObjectPresenter>(newItems: [ItemType], at index: Int, handler: DataSourceSectionChangeHandler?)
    func insert<ItemType: DataSourceObjectPresenter>(item: ItemType, at index: Int, handler: DataSourceSectionChangeHandler?)
    
}
