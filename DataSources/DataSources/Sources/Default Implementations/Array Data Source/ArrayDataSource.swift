//
//  ArrayDataSource.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

open class ArrayDataSource: DefaultDataSource, ArrayDataSourceRepresentable {

    // MARK: - Private -
    
    private func sectionChangeHandler(for sectionIndex: Int, with handler: SectionsChangeHandler?) -> SectionChangeHandler {
        return { (indices) in
            let indexPathes = indices.compactMap({ IndexPath(row: $0, section: sectionIndex) })
            handler?(indexPathes)
        }
    }
    
    // MARK: - Public -
    
    // MARK: Append
    
    public func append(with items: [PresenterType], toSectionAt sectionIndex: Int, handler: SectionsChangeHandler?) {
        guard sections.indices.contains(sectionIndex) else { return }
        let section = sections[sectionIndex]
        section.append(with: items, handler: sectionChangeHandler(for: sectionIndex, with: handler))
    }
    
    public func append(with newSections: [SectionRepresentable], handler: DataSourceChangeHandler?) {
        guard !newSections.isEmpty else { return }
        let diff = newSections.indices.newRange(offsetBy: sections.count).asIndexSet()
        sections.append(contentsOf: newSections)
        handler?(diff)
    }
    
    // MARK: Remove
    
    public func remove(itemAt indexPath: IndexPath) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.remove(itemAt: indexPath.row)
    }
    
    public func removeAllItems(handler: SectionsChangeHandler?) {
        let deletedIndexPathes = indexPathes
        sections.forEach({ $0.removeAll(with: nil) })
        handler?(deletedIndexPathes)
    }
    
    public func remove(sectionAt index: Int) {
        guard sections.indices.contains(index) else { return }
        sections.remove(at: index)
    }
    
    public func removeAllSections(handler: DataSourceChangeHandler?) {
        let deletedIndices = sectionsIndices
        remove(sectionsAt: deletedIndices)
        handler?(deletedIndices)
    }
    
    // MARK: Insert
    
    public func insert(with items: [PresenterType], at indexPath: IndexPath, handler: SectionsChangeHandler?) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.insert(with: items, at: indexPath.row, handler: sectionChangeHandler(for: indexPath.section, with: handler))
    }
    
    public func insert(with newSections: [SectionRepresentable], at index: Int, handler: DataSourceChangeHandler?) {
        guard !newSections.isEmpty, sections.indices.contains(index) || index == 0 else { return }
        let diff = newSections.indices.newRange(offsetBy: index).asIndexSet()
        sections.insert(contentsOf: newSections, at: index)
        handler?(diff)
    }

    // MARK: Replace/Reorder
    
    public func replace(itemAt indexPath: IndexPath, with item: PresenterType) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.replace(itemAt: indexPath.row, with: item)
    }
    
    public func reorderItems(at sourceIndexPath: IndexPath, and destinationIndexPath: IndexPath) {
        guard sections.indices.contains(sourceIndexPath.section), sections.indices.contains(destinationIndexPath.section) else { return }
        if sourceIndexPath.section == destinationIndexPath.section {
            reorderItems(in: sourceIndexPath.section, at: sourceIndexPath.row, and: destinationIndexPath.row)
        } else {
            guard let sourceItem: PresenterType = item(at: sourceIndexPath) else { return }
            if numberOfItems(in: destinationIndexPath.section) > destinationIndexPath.row {
                insert(with: sourceItem, at: destinationIndexPath)
            } else {
                append(with: sourceItem, toSectionAt: destinationIndexPath.section, handler: nil)
            }
            remove(itemAt: sourceIndexPath)
        }
    }
    
    public func replace(sectionAt index: Int, with section: SectionRepresentable) {
        guard sections.indices.contains(index) else { return }
        sections[index] = section
    }
    
    public func reorderSections(at sourceIndex: Int, and destinationIndex: Int) {
        guard sections.indices.contains(sourceIndex), sections.indices.contains(destinationIndex) else { return }
        sections.rearrange(from: sourceIndex, to: destinationIndex)
    }
    
    // MARK: - Private -
    
    private func reorderItems(in sectionIndex: Int, at sourceIndex: Int, and destinationIndex: Int) {
        guard sections.indices.contains(sectionIndex) else { return }
        let section = sections[sectionIndex]
        section.reorderItems(at: sourceIndex, and: destinationIndex)
    }
    
}
