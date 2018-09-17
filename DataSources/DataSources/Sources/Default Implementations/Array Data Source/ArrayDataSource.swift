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
    
    public func append(with items: [PresenterType], toSectionAt sectionIndex: Int, handler: SectionsChangeHandler?) {
        guard sections.indices.contains(sectionIndex) else { return }
        let section = sections[sectionIndex]
        section.append(with: items, handler: sectionChangeHandler(for: sectionIndex, with: handler))
    }
    
    public func append(with item: PresenterType, toSectionAt sectionIndex: Int, handler: SectionsChangeHandler?) {
        guard sections.indices.contains(sectionIndex) else { return }
        let section = sections[sectionIndex]
        section.append(with: item, handler: sectionChangeHandler(for: sectionIndex, with: handler))
    }
    
    public func append(with newSections: [SectionRepresentable], handler: DataSourceChangeHandler?) {
        guard !newSections.isEmpty else { return }
        let diff = newSections.indices.newRange(offsetBy: sections.count).asIndexSet()
        sections.append(contentsOf: newSections)
        handler?(diff)
    }
    
    public func append(with newSection: SectionRepresentable, handler: DataSourceChangeHandler?) {
        let diff = IndexSet([sections.endIndex])
        sections.append(newSection)
        handler?(diff)
    }
    
    public func remove(itemsAt indexPathes: [IndexPath]) {
        indexPathes.forEach { [weak self] (indexPath) in
            self?.remove(itemAt: indexPath)
        }
    }
    
    public func remove(itemAt indexPath: IndexPath) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.remove(itemAt: indexPath.row)
    }
    
    public func remove(sectionsAt indices: [Int]) {
        indices.forEach { [weak self] (index) in
            self?.remove(sectionAt: index)
        }
    }
    
    public func remove(sectionAt index: Int) {
        guard sections.indices.contains(index) else { return }
        sections.remove(at: index)
    }
    
    public func insert(with items: [PresenterType], at indexPath: IndexPath, handler: SectionsChangeHandler?) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.insert(with: items, at: indexPath.row, handler: sectionChangeHandler(for: indexPath.section, with: handler))
    }
    
    public func insert(with item: PresenterType, at indexPath: IndexPath) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.insert(with: item, at: indexPath.row)
    }
    
    public func insert(with newSections: [SectionRepresentable], at index: Int, handler: DataSourceChangeHandler?) {
        guard !newSections.isEmpty, sections.indices.contains(index) || index == 0 else { return }
        let diff = newSections.indices.newRange(offsetBy: index).asIndexSet()
        sections.insert(contentsOf: newSections, at: index)
        handler?(diff)
    }
    
    public func insert(with newSection: SectionRepresentable, at index: Int, handler: DataSourceChangeHandler?) {
        guard sections.indices.contains(index) || index == 0 else { return }
        sections.insert(newSection, at: index)
        handler?([index])
    }
    
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
