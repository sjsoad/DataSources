//
//  Range.swift
//  DataSources
//
//  Created by Sergey Kostyan on 16.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

extension CountableRange where Bound == Int {
    
    func newRange(offsetBy distance: Int) -> CountableRange {
        let newStartIndex = lowerBound + distance
        let newEndIndex = upperBound + distance
        return newStartIndex..<newEndIndex
    }
    
    func asArray() -> [Int] {
        return Array(lowerBound..<upperBound)
    }
    
    func asIndexSet() -> IndexSet {
        return IndexSet(lowerBound..<upperBound)
    }
    
}
