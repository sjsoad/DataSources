//
//  Constants.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

public typealias SectionChangeHandler = (([Int]) -> Void)
public typealias SectionsChangeHandler = (([IndexPath]) -> Void)
public typealias DataSourceChangeHandler = ((IndexSet) -> Void)
