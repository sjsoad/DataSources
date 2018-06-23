//
//  Reusable.swift
//  DataSources
//
//  Created by Sergey on 05.06.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit
import Foundation

public protocol Reusable {

    static var reuseIdentifier: String { get }
    
}

public extension Reusable where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
