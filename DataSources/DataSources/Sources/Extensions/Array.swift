//
//  Array.swift
//  DataSources
//
//  Created by Sergey Kostyan on 15.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func rearrange(from: Int, to: Int) {
        insert(remove(at: from), at: to)
    }
    
}
