//
//  Range.swift
//  DataSources
//
//  Created by Sergey Kostyan on 16.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

extension Range where Element == Int {
    
    func newRange(offsetBy distance: Int) -> Range {
        let newStartIndex = startIndex + distance
        let newEndIndex = endIndex + distance
        return newStartIndex..<newEndIndex
    }
    
    func asArray() -> [Int] {
        return Array(self)
    }
    
    func asIndexSet() -> IndexSet {
        return IndexSet(self)
    }
    
}
