//
//  DataSourceRepresentable.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import Foundation

public protocol DataSourceRepresentable {

    var isEmpty: Bool { get }
    var sectionsIndices: IndexSet { get }
    var indexPathes: [IndexPath] { get }
    
    func rowIndices(for section: Int) -> Range<Int>
    func indexPathes(for section: Int) -> [IndexPath]
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func section(at index: Int) -> SectionRepresentable?
    func item<PresenterType>(at indexPath: IndexPath) -> PresenterType?
    
}
