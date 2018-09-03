//
//  DataSourceReordering.swift
//  SKDataSources
//
//  Created by Sergey on 03.09.2018.
//

import Foundation

/*
 
 For propper reordering implement:
 func tableView(_ tableView: UITableView,
 targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
 toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
 
 */

public protocol DataSourceReordering {
    
    func replace(itemAt indexPath: IndexPath, with item: DataSourceObjectPresenter)
    func reorderItems(at sourceIndexPath: IndexPath, and destinationIndexPath: IndexPath)
    
    func replace(sectionAt index: Int, with section: SectionRepresentable)
    func reorderSections(at sourceIndex: Int, and destinationIndex: Int)
    
}
