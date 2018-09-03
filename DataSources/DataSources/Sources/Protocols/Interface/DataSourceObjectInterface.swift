//
//  DataSourceObjectInterface.swift
//  Pods
//
//  Created by Sergey on 05.06.2018.
//
//

import UIKit
import Foundation

public protocol DataSourceObjectInterface {
    
    associatedtype PresenterType
    
    var presenter: PresenterType? { get set }
    
}
