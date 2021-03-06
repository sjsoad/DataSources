//
//  ArrayDataSourceRepresentable.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import Foundation

public protocol ArrayDataSourceRepresentable {
    
    func append(with items: [PresenterType], toSectionAt index: Int, handler: SectionsChangeHandler?)
    func append(with item: PresenterType, toSectionAt index: Int, handler: SectionsChangeHandler?)
    
    func append(with newSections: [SectionRepresentable], handler: DataSourceChangeHandler?)
    func append(with newSection: SectionRepresentable, handler: DataSourceChangeHandler?)
    
    func remove(itemsAt indexPathes: [IndexPath])
    func remove(itemAt indexPath: IndexPath)
    func removeAllItems(handler: SectionsChangeHandler?)
    
    func remove(sectionsAt indices: IndexSet)
    func remove(sectionAt index: Int)
    func removeAllSections(handler: DataSourceChangeHandler?)
    
    func insert(with items: [PresenterType], at indexPath: IndexPath, handler: SectionsChangeHandler?)
    func insert(with item: PresenterType, at indexPath: IndexPath)
    
    func insert(with newSections: [SectionRepresentable], at index: Int, handler: DataSourceChangeHandler?)
    func insert(with newSection: SectionRepresentable, at index: Int, handler: DataSourceChangeHandler?)
    
    /*
    For propper reordering in UITableView implement:
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
    toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
    */
    
    func replace(itemAt indexPath: IndexPath, with item: PresenterType)
    func reorderItems(at sourceIndexPath: IndexPath, and destinationIndexPath: IndexPath)
    
    func replace(sectionAt index: Int, with section: SectionRepresentable)
    func reorderSections(at sourceIndex: Int, and destinationIndex: Int)
    
}

public extension ArrayDataSourceRepresentable {
    
    // MARK: - Append -
    
    func append(with item: PresenterType, toSectionAt sectionIndex: Int, handler: SectionsChangeHandler?) {
        append(with: [item], toSectionAt: sectionIndex, handler: handler)
    }
    
    func append(with newSection: SectionRepresentable, handler: DataSourceChangeHandler?) {
        append(with: [newSection], handler: handler)
    }
    
    // MARK: - Remove -
    
    func remove(itemsAt indexPathes: [IndexPath]) {
        indexPathes.forEach({ remove(itemAt: $0) })
    }
    
    func remove(sectionsAt indices: IndexSet) {
        indices.forEach({ remove(sectionAt: $0) })
    }
    
    // MARK: - Insert -
    
    func insert(with item: PresenterType, at indexPath: IndexPath) {
        insert(with: [item], at: indexPath, handler: nil)
    }
    
    func insert(with newSection: SectionRepresentable, at index: Int, handler: DataSourceChangeHandler?) {
        insert(with: [newSection], at: index, handler: handler)
    }
    
}
