//
//  DefaultSection.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

open class DefaultSection: NSObject, SectionRepresentable {
    
    private var items: [PresenterType]
    public private(set) var header: SectionHeaderRepresentable?
    public private(set) var footer: SectionFooterRepresentable?
    
    public init(with items: [PresenterType] = [], header: SectionHeaderRepresentable? = nil, footer: SectionFooterRepresentable? = nil) {
        self.items = items
        self.header = header
        self.footer = footer
    }
    
    public var isEmpty: Bool { return items.isEmpty }
    
    public func itemsCount() -> Int {
        return items.count
    }
    
    public func item<PresenterType>(at index: Int) -> PresenterType? {
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
    
    public func append(with newItems: [PresenterType], handler: SectionChangeHandler?) {
        guard !newItems.isEmpty else { return }
        let diff = newItems.indices.newRange(offsetBy: items.count).asArray()
        items.append(contentsOf: newItems)
        handler?(diff)
    }
    
    public func append(with item: PresenterType, handler: SectionChangeHandler?) {
        let diff = [items.endIndex]
        items.append(item)
        handler?(diff)
    }
    
    // MARK: - Remove -
    
    public func remove(itemsAt indices: [Int]) {
        indices.forEach { [weak self] (index) in
            self?.remove(itemAt: index)
        }
    }
    
    public func remove(itemAt index: Int) {
        guard items.indices.contains(index) else { return }
        items.remove(at: index)
    }
    
    public func removeAll(with handler: SectionChangeHandler?) {
        let indices = items.indices.asArray()
        items.removeAll()
        handler?(indices)
    }
    
    // MARK: - Insert -
    
    public func insert(with newItems: [PresenterType], at index: Int, handler: SectionChangeHandler?) {
        guard !newItems.isEmpty, items.indices.contains(index) || index == 0 else { return }
        let diff = newItems.indices.newRange(offsetBy: index).asArray()
        items.insert(contentsOf: newItems, at: index)
        handler?(diff)
    }
    
    public func insert(with item: PresenterType, at index: Int) {
        guard items.indices.contains(index) || index == 0 else { return }
        items.insert(item, at: index)
    }
    
    // MARK: - Replace -
    
    public func replace(itemAt index: Int, with item: PresenterType) {
        guard items.indices.contains(index) else { return }
        items[index] = item
    }
    
    // MARK: - Reorder -
    
    public func reorderItems(at sourceIndex: Int, and destinationIndex: Int) {
        guard items.indices.contains(sourceIndex), items.indices.contains(destinationIndex) else { return }
        items.rearrange(from: sourceIndex, to: destinationIndex)
    }
    
}
