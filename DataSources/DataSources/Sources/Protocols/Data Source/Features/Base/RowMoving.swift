//
//  RowMoving.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import Foundation

public protocol RowMoving: class {

    var canMoveRow: ((_ indexPath: IndexPath) -> Bool)? { get }
    var movingHandler: ((_ sourceIndexPath: IndexPath, _ destinationIndexPath: IndexPath) -> Void)? { get }
    
}
