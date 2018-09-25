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
    
    public var isEmpty: Bool { return numberOfSections() == 0 }
    
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
