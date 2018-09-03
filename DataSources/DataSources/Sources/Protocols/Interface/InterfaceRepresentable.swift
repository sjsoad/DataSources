//
//  InterfaceRepresentable.swift
//  DataSources
//
//  Created by Sergey Kostyan on 03.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

public protocol InterfaceRepresentable {
    
    associatedtype PresenterType
    
    var presenter: PresenterType? { get set }
    
}
