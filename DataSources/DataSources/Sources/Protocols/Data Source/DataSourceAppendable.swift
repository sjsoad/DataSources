//
//  DataSourceAppendable.swift
//  SKDataSources
//
//  Created by Sergey on 03.09.2018.
//

import Foundation

public protocol DataSourceAppendable {
    
    func append(items: [DataSourceObjectPresenter], toSectionAtIndex index: Int, handler: DataSourceSectionsChangeHandler?)
    func append(item: DataSourceObjectPresenter, toSectionAtIndex index: Int, handler: DataSourceSectionsChangeHandler?)
    
    // These methods lead to a mutation of the array of sections, so implemented in "View type"ArrayDataSource
    func append(newSections: [SectionRepresentable], handler: DataSourceChangeHandler?)
    func append(newSection: SectionRepresentable, handler: DataSourceChangeHandler?)
}
