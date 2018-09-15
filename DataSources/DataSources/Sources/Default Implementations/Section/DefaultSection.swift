//
//  DefaultSection.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

open class DefaultSection: NSObject, SectionRepresentable {

    private var items: [CellPresenterRepresentable]
    public private(set) var header: SectionHeaderRepresentable?
    public private(set) var footer: SectionFooterRepresentable?
    
    init(with items: [CellPresenterRepresentable] = [], header: SectionHeaderRepresentable? = nil, footer: SectionFooterRepresentable? = nil) {
        self.items = items
        self.header = header
        self.footer = footer
    }
    
    public func itemsCount() -> Int {
        return items.count
    }
    
    public func item<PresenterType>(at index: Int) ->  PresenterType? {
        guard items.indices.contains(index) else { return nil }
        return items[index] as? PresenterType
    }
    
    public func headerTitle() -> String? {
        return header?.headerTitle
    }
    
    public func footerTitle() -> String? {
        return footer?.footerTitle
    }
    
    // MARK: - Append -
    
    public func append(with newItems: [CellPresenterRepresentable], handler: SectionChangeHandler?) {
        items.append(contentsOf: newItems)
//        let diff = Array(lastIndex + 1...lastIndex + newItems.count)
//        handler?(diff)
    }
    
    public func append(with item: CellPresenterRepresentable, handler: SectionChangeHandler?) {
        items.append(item)
//        let diff = [items.count - 1]
//        handler?(diff)
    }
    
    // MARK: - Remove -
    
    public func remove(itemsAt indices: [Int]) {
        indices.forEach { [weak self] (index) in
            self?.remove(itemAt: index)
        }
    }
    
    public func remove(itemAt index: Int) {
        guard self.items.indices.contains(index) else { return }
        self.items.remove(at: index)
    }
    
    // MARK: - Insert -
    
    public func insert(with newItems: [CellPresenterRepresentable], at index: Int, handler: SectionChangeHandler?) {
        guard items.indices.contains(index) || index == 0 else { return }
        items.insert(contentsOf: newItems, at: index)
        let diff = Array(index...index + newItems.indices.last!)
        handler?(diff)
    }
    
    public func insert(with item: CellPresenterRepresentable, at index: Int, handler: SectionChangeHandler?) {
        guard items.indices.contains(index) || index == 0 else { return }
        items.insert(item, at: index)
        handler?([index])
    }
    
    // MARK: - Replace -
    
    public func replace(itemAt index: Int, with item: CellPresenterRepresentable) {
        guard items.indices.contains(index) else { return }
        items[index] = item
    }
    
    // MARK: - Reorder -
    
    public func reorderItems(at sourceIndex: Int, and destinationIndex: Int) {
        guard items.indices.contains(sourceIndex), items.indices.contains(destinationIndex) else { return }
        items.rearrange(from: sourceIndex, to: destinationIndex)
    }
    
}
