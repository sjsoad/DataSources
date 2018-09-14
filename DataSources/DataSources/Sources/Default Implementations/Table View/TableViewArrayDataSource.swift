//
//  TableViewArrayDataSource.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

open class TableViewArrayDataSource: ArrayDataSource, TableViewArrayDataSourceRepresentable {

    private var movingProvider: RowMoving?
    private var editingProvider: TableViewRowEditing?
    
    public init(with sections: [SectionRepresentable] = [], movingProvider: RowMoving? = nil, editingProvider: TableViewRowEditing? = nil) {
        super.init(with: sections)
        self.movingProvider = movingProvider
        self.editingProvider = editingProvider
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems(in: section)
    }
    
    // Row display
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle()
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerTitle()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let presenter: CellPresenterRepresentable = item(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: presenter.reuseIdentifier), let interface = cell as? DataSourceObjectInterface {
            interface.set(presenter: presenter)
            presenter.set(view: cell)
            presenter.configure()
            return cell
        }
        return UITableViewCell()
    }
    
    // Moving/reordering
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return movingProvider?.canMoveRow?(indexPath) ?? false
    }

    // Data manipulation - reorder / moving support
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        movingProvider?.movingHandler?(sourceIndexPath, destinationIndexPath)
    }
    
    // Data manipulation - insert and delete support

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        editingProvider?.edititngHandler?(editingStyle, indexPath)
    }

    // MARK: - Private -
    
    private func section(at index: Int) -> SectionRepresentable? {
        guard sections.indices.contains(index) else { return nil }
        return sections[index]
    }
    
}
