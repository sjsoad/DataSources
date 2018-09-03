//
//  SectionHeaderRepresentable.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

public protocol SectionHeaderRepresentable: PresenterRepresentable {

    var headerTitle: String? { get set }

}
