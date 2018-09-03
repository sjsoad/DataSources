//
//  DataSourceSectionAppendable.swift
//  SKDataSources
//
//  Created by Sergey on 03.09.2018.
//

import Foundation

public protocol DataSourceSectionAppendable {
    
    func append<ItemType: DataSourceObjectPresenter>(newItems: [ItemType], handler: DataSourceSectionChangeHandler?)
    func append<ItemType: DataSourceObjectPresenter>(item: ItemType, handler: DataSourceSectionChangeHandler?)
    
}
