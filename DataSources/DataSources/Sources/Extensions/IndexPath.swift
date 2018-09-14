//
//  IndexPath.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

extension IndexPath {
    
    static func generateIndexPathes(from indexes: [Int], sectionIndex: Int) -> [IndexPath] {
        var indexPathes = [IndexPath]()
        indexes.forEach({ (rowIndex) in
            indexPathes.append(IndexPath(row: rowIndex, section: sectionIndex))
        })
        return indexPathes
    }
    
}
