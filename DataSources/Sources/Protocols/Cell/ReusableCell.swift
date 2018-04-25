//
//  ReusableCell.swift
//  GeoTouch
//
//  Created by Sergey on 20.03.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

public protocol ReusableCell {
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
}

extension ReusableCell where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
}
