//
//  ArrayDataSource.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

open class ArrayDataSource: DefaultDataSource, ArrayDataSourceRepresentable {
    
    public func append(with items: [CellPresenterRepresentable], toSectionAtIndex sectionIndex: Int, handler: SectionsChangeHandler?) {
        guard sections.indices.contains(sectionIndex), !items.isEmpty else { return }
        let section = sections[sectionIndex]
        section.append(with: items) { (indices) in
            let indexPathes = indices.compactMap({ IndexPath(row: $0, section: sectionIndex) })
            handler?(indexPathes)
        }
    }
    
    public func append(with item: CellPresenterRepresentable, toSectionAtIndex sectionIndex: Int, handler: SectionsChangeHandler?) {
        guard sections.indices.contains(sectionIndex) else { return }
        let section = sections[sectionIndex]
        section.append(with: item) { (indices) in
            let indexPathes = indices.compactMap({ IndexPath(row: $0, section: sectionIndex) })
            handler?(indexPathes)
        }
    }
    
    public func append(with newSections: [SectionRepresentable], handler: DataSourceChangeHandler?) {
        guard !newSections.isEmpty else { return }
        let lastIndex = sections.count - 1
        self.sections.append(contentsOf: newSections)
        let diff = IndexSet(lastIndex + 1...lastIndex + newSections.count)
        handler?(diff)
    }
    
    public func append(with newSection: SectionRepresentable, handler: DataSourceChangeHandler?) {
        self.sections.append(newSection)
        let diff = IndexSet([self.sections.count - 1])
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
    
    public func insert(with items: [CellPresenterRepresentable], at indexPath: IndexPath, handler: SectionsChangeHandler?) {
        guard sections.indices.contains(indexPath.section), !items.isEmpty else { return }
        let section = sections[indexPath.section]
        section.insert(with: items, at: indexPath.row) { (indices) in
            let indexPathes = indices.compactMap({ IndexPath(row: $0, section: indexPath.section) })
            handler?(indexPathes)
        }
    }
    
    public func insert(with item: CellPresenterRepresentable, at indexPath: IndexPath, handler: SectionsChangeHandler?) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.insert(with: item, at:  indexPath.row) { (indices) in
            let indexPathes = indices.compactMap({ IndexPath(row: $0, section: indexPath.section) })
            handler?(indexPathes)
        }
    }
    
    public func insert(with newSections: [SectionRepresentable], at index: Int, handler: DataSourceChangeHandler?) {
        guard !newSections.isEmpty, sections.indices.contains(index) || index == 0 else { return }
        sections.insert(contentsOf: newSections, at: index)
        let diff = IndexSet(index...index + sections.count - 1)
        handler?(diff)
    }
    
    public func insert(with newSection: SectionRepresentable, at index: Int, handler: DataSourceChangeHandler?) {
        self.sections.insert(newSection, at: index)
        handler?([index])
    }
    
    public func replace(itemAt indexPath: IndexPath, with item: CellPresenterRepresentable) {
        guard sections.indices.contains(indexPath.section) else { return }
        let section = sections[indexPath.section]
        section.replace(itemAt: indexPath.row, with: item)
    }
    
    public func reorderItems(at sourceIndexPath: IndexPath, and destinationIndexPath: IndexPath) {
        guard sections.indices.contains(sourceIndexPath.section), sections.indices.contains(destinationIndexPath.section) else { return }
        if sourceIndexPath.section == destinationIndexPath.section {
            let section = sections[sourceIndexPath.section]
            section.reorderItems(at: sourceIndexPath.row, and: destinationIndexPath.row)
        } else {
            let destinationSection = sections[destinationIndexPath.section]
            let sourceSection = sections[sourceIndexPath.section]
            guard let sourceItem: CellPresenterRepresentable = sourceSection.item(at: sourceIndexPath.row) else { return }
            if destinationSection.itemsCount() > destinationIndexPath.row {
                destinationSection.insert(with: sourceItem, at: destinationIndexPath.row, handler: nil)
            } else {
                destinationSection.append(with: sourceItem, handler: nil)
            }
            sourceSection.remove(itemAt: sourceIndexPath.row)
        }
    }
    
    public func replace(sectionAt index: Int, with section: SectionRepresentable) {
        guard sections.indices.contains(index) else { return }
        self.sections[index] = section
    }
    
    public func reorderSections(at sourceIndex: Int, and destinationIndex: Int) {
        guard sections.indices.contains(sourceIndex), sections.indices.contains(destinationIndex) else { return }
        self.sections.swapAt(sourceIndex, destinationIndex)
    }

    
}
