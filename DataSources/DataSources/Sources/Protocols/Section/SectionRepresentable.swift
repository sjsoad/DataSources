//
//  SectionRepresentable.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

public protocol SectionRepresentable {
    
    var header: SectionHeaderRepresentable? { get }
    var footer: SectionFooterRepresentable? { get }
    var isEmpty: Bool { get }
    
    func itemsCount() -> Int
    func item<PresenterType>(at index: Int) -> PresenterType?
    func headerTitle() -> String?
    func footerTitle() -> String?
    
    func append(with newItems: [PresenterType], handler: SectionChangeHandler?)
    func append(with item: PresenterType, handler: SectionChangeHandler?)
    
    func remove(itemsAt indices: [Int])
    func remove(itemAt index: Int)
    func removeAll(with handler: SectionChangeHandler?)
    
    func insert(with newItems: [PresenterType], at index: Int, handler: SectionChangeHandler?)
    func insert(with item: PresenterType, at index: Int)
    
    func replace(itemAt index: Int, with item: PresenterType)
    
    func reorderItems(at sourceIndex: Int, and destinationIndex: Int)
    
}

public extension SectionRepresentable {
    
    // MARK: - Utils -
    
    func headerTitle() -> String? {
        return header?.headerTitle
    }
    
    func footerTitle() -> String? {
        return footer?.footerTitle
    }
    
    // MARK: - Append -
    
    func append(with item: PresenterType, handler: SectionChangeHandler?) {
        append(with: [item], handler: handler)
    }
    
    // MARK: - Remove -
    
    func remove(itemsAt indices: [Int]) {
        indices.forEach({ remove(itemAt: $0) })
    }
    
    // MARK: - Insert -
    
    func insert(with item: PresenterType, at index: Int) {
        insert(with: [item], at: index, handler: nil)
    }
    
}
