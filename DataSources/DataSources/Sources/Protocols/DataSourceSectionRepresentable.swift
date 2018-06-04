//
//  DataSourceSectionRepresentable.swift
//  SwiftUtils
//
//  Created by Sergey on 17.10.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import Foundation

public typealias DataSourceSectionChangeHandler = (([Int]) -> Void)

public protocol DataSourceSectionRepresentable {

    var items: [DataSourceObjectPresenter] { get }
    var header: SectionHeader? { get }
    var footer: SectionFooter? { get }
    
}

// MARK: - DataSourceSectionAppendable -

public protocol DataSourceSectionAppendable {

    func append(newItems: [DataSourceObjectPresenter], handler: DataSourceSectionChangeHandler?)
    func append(item: DataSourceObjectPresenter, handler: DataSourceSectionChangeHandler?)
    
}

// MARK: - DataSourceSectionRemovable -

public protocol DataSourceSectionRemovable {
    
    func remove(itemsAt indexes: [Int])
    func remove(itemAt index: Int)
    
}

// MARK: - DataSourceSectionInsertable -

public protocol DataSourceSectionInsertable {
    
    func insert(newItems: [DataSourceObjectPresenter], at index: Int, handler: DataSourceSectionChangeHandler?)
    func insert(item: DataSourceObjectPresenter, at index: Int, handler: DataSourceSectionChangeHandler?)
    
}

// MARK: - DataSourceSectionReorderable -

public protocol DataSourceSectionReordering {
    
    func replace(itemAt index: Int, with item: DataSourceObjectPresenter)
    func reorderItems(at sourceIndex: Int, and destinationIndex: Int)
    
}
