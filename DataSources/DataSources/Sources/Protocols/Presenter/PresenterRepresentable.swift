//
//  PresenterRepresentable.swift
//  DataSources
//
//  Created by Sergey Kostyan on 03.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

public protocol PresenterRepresentable: Configurable {
    
    associatedtype InterfaceType
    
    var view: InterfaceType? { get set }
    var reuseIdentifier: String { get }
    
}
