//
//  DefaultDataSource.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

open class DefaultDataSource: NSObject, DataSourceRepresentable {
    
    public var sections: [SectionRepresentable]
    
    public init(with sections: [SectionRepresentable]) {
        self.sections = sections
    }
    
    // MARK: - Utils -
    
    public var isEmpty: Bool { return sections.isEmpty }
    
    public var sectionsIndices: IndexSet {
        return IndexSet(sections.indices)
    }
    
    public var indexPathes: [IndexPath] {
        return sectionsIndices.flatMap({ (sectionIndex) -> [IndexPath] in
            return indexPathes(for: sectionIndex)
        })
    }
    
    public func rowIndices(for section: Int) -> Range<Int> {
        return 0..<numberOfItems(in: section)
    }
    
    public func indexPathes(for section: Int) -> [IndexPath] {
        return rowIndices(for: section).compactMap({ IndexPath(item: $0, section: section) })
    }
    
    // MARK: - Common -
    
    public func numberOfSections() -> Int {
        return sections.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        guard sections.indices.contains(section) else { return 0 }
        return sections[section].itemsCount()
    }
    
    public func section(at index: Int) -> SectionRepresentable? {
        guard sections.indices.contains(index) else { return nil }
        return sections[index]
    }
    
    public func item<PresenterType>(at indexPath: IndexPath) -> PresenterType? {
        guard sections.indices.contains(indexPath.section) else { return nil }
        return sections[indexPath.section].item(at: indexPath.row)
    }
    
}
