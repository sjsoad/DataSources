//
//  DataSourceModel.swift
//  GeoTouch
//
//  Created by Sergey on 20.03.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import Foundation

public protocol DataSourceModel: DataSourceModelIdentifying {
    
}

public protocol DataSourceModelIdentifying {
    
    var reuseIdentifier: String { get }

}
