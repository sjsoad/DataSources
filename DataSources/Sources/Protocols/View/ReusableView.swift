//
//  ReusableViewProtocol.swift
//  Nioxin
//
//  Created by Sergey on 29.05.17.
//  Copyright © 2017 grossum solutions. All rights reserved.
//

import UIKit
import Foundation

public protocol ReusableView {

    static var reuseIdentifier: String { get }
    static var nibName: String { get }
    
}

extension ReusableView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
    
}
