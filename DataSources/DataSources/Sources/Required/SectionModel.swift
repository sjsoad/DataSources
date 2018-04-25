//
//  SectionModel.swift
//  SwiftUtils
//
//  Created by Sergey on 17.10.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

public class SectionModel: NSObject, DataSourceSectionRepresentable {

    private(set) public var items: [DataSourceModel]
    private(set) public var header: SectionHeader?
    private(set) public var footer: SectionFooter?
    
    public init(withItems items: [DataSourceModel],
         header: SectionHeader? = nil,
         footer: SectionFooter? = nil) {
        self.items = items
        self.header = header
        self.footer = footer
    }
    
}

// MARK: - DataSourceSectionAppendable -

extension SectionModel: DataSourceSectionAppendable {
    
    public func append(newItems: [DataSourceModel], handler: DataSourceSectionChangeHandler?) {
        let lastIndex = items.count - 1
        items.append(contentsOf: newItems)
        let diff = Array(lastIndex + 1...lastIndex + newItems.count)
        handler?(diff)
    }
    
    public func append(item: DataSourceModel, handler: DataSourceSectionChangeHandler?) {
        items.append(item)
        let diff = [items.count - 1]
        handler?(diff)
    }
    
}

// MARK: - DataSourceSectionRemovable -

extension SectionModel: DataSourceSectionRemovable {
    
    public func remove(itemsAt indexes: [Int]) {
        indexes.forEach { [weak self] (index) in
            self?.remove(itemAt: index)
        }
    }
    
    public func remove(itemAt index: Int) {
        guard self.items.indices.contains(index) else { return }
        self.items.remove(at: index)
    }
    
}

// MARK: - DataSourceSectionInsertable -

extension SectionModel: DataSourceSectionInsertable {
    
    public func insert(newItems: [DataSourceModel], at index: Int, handler: DataSourceSectionChangeHandler?) {
        guard self.items.indices.contains(index) || index == 0 else { return }
        self.items.insert(contentsOf: newItems, at: index)
        let diff = Array(index...index + newItems.count - 1)
        handler?(diff)
    }
    
    public func insert(item: DataSourceModel, at index: Int, handler: DataSourceSectionChangeHandler?) {
        guard self.items.indices.contains(index) || index == 0 else { return }
        self.items.insert(item, at: index)
        let diff = [index]
        handler?(diff)
    }
    
}

extension SectionModel: DataSourceSectionReordering {    
    
    public func replace(itemAt index: Int, with item: DataSourceModel) {
        guard self.items.indices.contains(index) else { return }
        self.items[index] = item
    }
    
    public func reorderItems(at sourceIndex: Int, and destinationIndex: Int) {
        guard self.items.indices.contains(sourceIndex), self.items.indices.contains(destinationIndex) else { return }
        self.items.swapAt(sourceIndex, destinationIndex)
    }
    
}
