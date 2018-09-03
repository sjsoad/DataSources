//
//  DataSourceInsertable.swift
//  SKDataSources
//
//  Created by Sergey on 03.09.2018.
//

import Foundation

public protocol DataSourceInsertable {
    
    func insert(items: [DataSourceObjectPresenter], at indexPath: IndexPath, handler: DataSourceSectionsChangeHandler?)
    func insert(item: DataSourceObjectPresenter, at indexPath: IndexPath, handler: DataSourceSectionsChangeHandler?)
    
    // These methods lead to a mutation of the array of sections, so implemented in "View type"ArrayDataSource
    func insert(newSections: [SectionRepresentable], at index: Int, handler: DataSourceChangeHandler?)
    func insert(newSection: SectionRepresentable, at index: Int, handler: DataSourceChangeHandler?)
    
}
