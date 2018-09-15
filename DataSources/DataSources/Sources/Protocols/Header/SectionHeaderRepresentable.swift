//
//  SectionHeaderRepresentable.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

public protocol SectionHeaderRepresentable: CellPresenterRepresentable {

    var headerTitle: String? { get set }

}