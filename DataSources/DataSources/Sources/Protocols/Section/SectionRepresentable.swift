//
//  SectionRepresentable.swift
//  SKDataSources
//
//  Created by Sergey on 03.09.2018.
//

import Foundation

public protocol SectionRepresentable: DataSourceSectionAppendable, DataSourceSectionRemovable,
DataSourceSectionInsertable, DataSourceSectionReordering {
    
    var items: [PresenterRepresentable] { get }
    var header: SectionHeaderRepresentable? { get }
    var footer: SectionFooterRepresentable? { get }

    
}
