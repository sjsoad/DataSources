//
//  DefaultSection.swift
//  DataSources
//
//  Created by Sergey Kostyan on 03.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

open class DefaultSection: SectionRepresentable {
    
    public private(set) var items: [PresenterRepresentable]
    public private(set) var header: SectionHeaderRepresentable?
    public private(set) var footer: SectionFooterRepresentable?
    
    public init(_ items: [PresenterRepresentable] = [], _ header: SectionHeaderRepresentable? = nil, _ footer: SectionFooterRepresentable? = nil) {
        self.items = items
        self.header = header
        self.footer = footer
    }
    
}
