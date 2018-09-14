//
//  SectionRepresentable.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

public protocol SectionRepresentable {
    
    var header: SectionHeaderRepresentable? { get }
    var footer: SectionFooterRepresentable? { get }
    
    func itemsCount() -> Int
    func item<PresenterType>(at index: Int) ->  PresenterType?
    func headerTitle() -> String?
    func footerTitle() -> String?
    
    func append(newItems: [CellPresenterRepresentable], handler: SectionChangeHandler?)
    func append(item: CellPresenterRepresentable, handler: SectionChangeHandler?)
    
    func remove(itemsAt indexes: [Int])
    func remove(itemAt index: Int)
    
    func insert(newItems: [CellPresenterRepresentable], at index: Int, handler: SectionChangeHandler?)
    func insert(item: CellPresenterRepresentable, at index: Int, handler: SectionChangeHandler?)
    
    func replace(itemAt index: Int, with item: CellPresenterRepresentable)
    
    func reorderItems(at sourceIndex: Int, and destinationIndex: Int)
    
}
