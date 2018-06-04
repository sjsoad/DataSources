//
//  ArrayDataSourceRepresentable.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import Foundation

public typealias DataSourceSectionsChangeHandler = (([IndexPath]) -> Void)
public typealias DataSourceChangeHandler = (([Int]) -> Void)

public protocol ArrayDataSourceRepresentable: DataSourceRepresentable, DataSourceAppendable, DataSourceRemovable, DataSourceInsertable,
DataSourceReordering {

    var sections: [SectionModel] { get }
    
}

// MARK: - DataSourceAppendable -

public protocol DataSourceAppendable {
    
    func append(items: [DataSourceObjectPresenter], toSectionAtIndex index: Int, handler: DataSourceSectionsChangeHandler?)
    func append(item: DataSourceObjectPresenter, toSectionAtIndex index: Int, handler: DataSourceSectionsChangeHandler?)
    
    // These methods lead to a mutation of the array of sections, so implemented in "View type"ArrayDataSource
    func append(newSections: [SectionModel], handler: DataSourceChangeHandler?)
    func append(newSection: SectionModel, handler: DataSourceChangeHandler?)
}

// MARK: - DataSourceRemovable -

public protocol DataSourceRemovable {
    
    func remove(itemsAt indexPathes: [IndexPath])
    func remove(itemAt indexPath: IndexPath)
    
    // These methods lead to a mutation of the array of sections, so implemented in "View type"ArrayDataSource
    func remove(sectionsAt indexes: [Int])
    func remove(sectionAt index: Int)
    
}

// MARK: - DataSourceInsertable -

public protocol DataSourceInsertable {
    
    func insert(items: [DataSourceObjectPresenter], at indexPath: IndexPath, handler: DataSourceSectionsChangeHandler?)
    func insert(item: DataSourceObjectPresenter, at indexPath: IndexPath, handler: DataSourceSectionsChangeHandler?)
    
    // These methods lead to a mutation of the array of sections, so implemented in "View type"ArrayDataSource
    func insert(newSections: [SectionModel], at index: Int, handler: DataSourceChangeHandler?)
    func insert(newSection: SectionModel, at index: Int, handler: DataSourceChangeHandler?)
    
}

// MARK: - DataSourceReordering -

/*
 
 For propper reordering implement:
 func tableView(_ tableView: UITableView,
 targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
 toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
 
*/

public protocol DataSourceReordering {
    
    func replace(itemAt indexPath: IndexPath, with item: DataSourceObjectPresenter)
    func reorderItems(at sourceIndexPath: IndexPath, and destinationIndexPath: IndexPath)
    
    func replace(sectionAt index: Int, with section: SectionModel)
    func reorderSections(at sourceIndex: Int, and destinationIndex: Int)
    
}

public extension ArrayDataSourceRepresentable where Self: NSObject {
    
    // MARK: - DataSourceRepresentable -
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfItemsInSection(sectionIndex: Int) -> Int {
        let section = sections[sectionIndex]
        let items = section.items
        return items.count
    }
    
    func itemAtIndexPath(indexPath: IndexPath) -> DataSourceObjectPresenter? {
        guard sections.indices.contains(indexPath.section) else { return nil }
        let section = sections[indexPath.section]
        let items = section.items
        guard items.indices.contains(indexPath.row) else { return nil }
        let item = items[indexPath.row]
        return item
    }
    
    // MARK: - DataSourceAppendable -
    
    func append(items: [DataSourceObjectPresenter], toSectionAtIndex sectionIndex: Int, handler: DataSourceSectionsChangeHandler?) {
        guard sections.indices.contains(sectionIndex), !items.isEmpty else { return }
        let section = sections[sectionIndex]
        section.append(newItems: items) { (indexes) in
            let indexPathes = IndexPath.generateIndexPathes(from: indexes, sectionIndex: sectionIndex)
            handler?(indexPathes)
        }
    }
    
    func append(item: DataSourceObjectPresenter, toSectionAtIndex sectionIndex: Int, handler: DataSourceSectionsChangeHandler?) {
        guard sections.indices.contains(sectionIndex) else { return }
        let section = sections[sectionIndex]
        section.append(item: item) { (indexes) in
            let indexPathes = IndexPath.generateIndexPathes(from: indexes, sectionIndex: sectionIndex)
            handler?(indexPathes)
        }
    }
    
    // MARK: - DataSourceRemovable -
    
    func remove(itemsAt indexPathes: [IndexPath]) {
        indexPathes.forEach { [weak self] (indexPath) in
            self?.remove(itemAt: indexPath)
        }
    }
    
    func remove(itemAt indexPath: IndexPath) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.remove(itemAt: indexPath.row)
    }
    
    // MARK: - DataSourceInsertable -
    
    func insert(items: [DataSourceObjectPresenter], at indexPath: IndexPath, handler: DataSourceSectionsChangeHandler?) {
        guard sections.indices.contains(indexPath.section), !items.isEmpty else { return }
        let section = sections[indexPath.section]
        section.insert(newItems: items, at: indexPath.row) { (indexes) in
            let indexPathes = IndexPath.generateIndexPathes(from: indexes, sectionIndex: indexPath.section)
            handler?(indexPathes)
        }
    }

    func insert(item: DataSourceObjectPresenter, at indexPath: IndexPath, handler: DataSourceSectionsChangeHandler?) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.insert(item: item, at:  indexPath.row) { (indexes) in
            let indexPathes = IndexPath.generateIndexPathes(from: indexes, sectionIndex: indexPath.section)
            handler?(indexPathes)
        }
    }
    
    // MARK: - DataSourceReordering -
    
    func replace(itemAt indexPath: IndexPath, with item: DataSourceObjectPresenter) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.replace(itemAt: indexPath.row, with: item)
    }
    
    func reorderItems(at sourceIndexPath: IndexPath, and destinationIndexPath: IndexPath) {
        guard sections.indices.contains(sourceIndexPath.section), sections.indices.contains(destinationIndexPath.section) else { return }
        if sourceIndexPath.section == destinationIndexPath.section {
            let section = sections[sourceIndexPath.section]
            section.reorderItems(at: sourceIndexPath.row, and: destinationIndexPath.row)
        } else {
            let destinationSection = sections[destinationIndexPath.section]
            let sourceSection = sections[sourceIndexPath.section]
            let sourceItem = sourceSection.items[sourceIndexPath.row]
            if destinationSection.items.indices.contains(destinationIndexPath.row) {
                destinationSection.insert(item: sourceItem, at: destinationIndexPath.row, handler: nil)
            } else {
                destinationSection.append(item: sourceItem, handler: nil)
            }
            sourceSection.remove(itemAt: sourceIndexPath.row)
        }
    }
    
}

private extension IndexPath {
    
    static func generateIndexPathes(from indexes: [Int], sectionIndex: Int) -> [IndexPath] {
        var indexPathes = [IndexPath]()
        indexes.forEach({ (rowIndex) in
            indexPathes.append(IndexPath(row: rowIndex, section: sectionIndex))
        })
        return indexPathes
    }
    
}
