//
//  Nibable.swift
//  DataSources
//
//  Created by Sergey on 05.06.2018.
//Copyright © 2018 Sergey. All rights reserved.
//

import UIKit
import Foundation

public protocol Nibable {

    static var nibName: String { get }
    
}

public extension Nibable {

    static var nibName: String {
        return String(describing: self)
    }
    
}
