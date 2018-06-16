//
//  TableViewArrayDataSource.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

open class TableViewArrayDataSource: NSObject, ArrayDataSourceRepresentable {

    private(set) public var sections: [SectionModel] = []
    private var editingProvider: TableViewRowEditing?
    private var movingProvider: TableViewRowMoving?
    
    public init(with sections: [SectionModel], editingProvider: TableViewRowEditing? = nil, movingProvider: TableViewRowMoving? = nil) {
        self.sections = sections
        self.editingProvider = editingProvider
        self.movingProvider = movingProvider
    }
    
    // MARK: - DataSourceAppendable -
    
    public func append(newSections: [SectionModel], handler: DataSourceChangeHandler?) {
        guard !newSections.isEmpty else { return }
        let lastIndex = sections.count - 1
        self.sections.append(contentsOf: newSections)
        let diff = IndexSet(lastIndex + 1...lastIndex + newSections.count)
        handler?(diff)
    }
    
    public func append(newSection: SectionModel, handler: DataSourceChangeHandler?) {
        self.sections.append(newSection)
        let diff = IndexSet([self.sections.count - 1])
        handler?(diff)
    }
    
    // MARK: - DataSourceRemovable -
    
    public func remove(sectionsAt indexes: [Int]) {
        indexes.forEach { [weak self] (index) in
            self?.remove(sectionAt: index)
        }
    }
    
    public func remove(sectionAt index: Int) {
        guard sections.indices.contains(index) else { return }
        sections.remove(at: index)
    }
 
    // MARK: - DataSourceInsertable -
    
    public func insert(newSections: [SectionModel], at index: Int, handler: DataSourceChangeHandler?) {
        guard !newSections.isEmpty, sections.indices.contains(index) || index == 0 else { return }
        sections.insert(contentsOf: newSections, at: index)
        let diff = IndexSet(index...index + sections.count - 1)
        handler?(diff)
    }
    
    public func insert(newSection: SectionModel, at index: Int, handler: DataSourceChangeHandler?) {
        self.sections.insert(newSection, at: index)
        handler?([index])
    }
    
    // MARK: - DataSourceReordering -
    
    public func replace(sectionAt index: Int, with section: SectionModel) {
        guard sections.indices.contains(index) else { return }
        self.sections[index] = section
    }
    
    public func reorderSections(at sourceIndex: Int, and destinationIndex: Int) {
        guard sections.indices.contains(sourceIndex), sections.indices.contains(destinationIndex) else { return }
        self.sections.swapAt(sourceIndex, destinationIndex)
    }
    
}

// MARK: - UITableViewDataSource -

extension TableViewArrayDataSource: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections()
    }
    
    // Row display
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionModel = sections[section]
        return sectionModel.header?.headerTitle
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let sectionModel = sections[section]
        return sectionModel.footer?.footerTitle
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let presenter: DataSourceObjectPresenter = itemAtIndexPath(indexPath: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: presenter.reuseIdentifier), let interface = cell as? DataSourceObjectInterface {
            interface.set(presenter: presenter)
            presenter.set(view: cell)
            presenter.configure()
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItemsInSection(sectionIndex: section)
    }
    
    // Moving/reordering
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return movingProvider?.canMoveRow?(indexPath) ?? false
    }
    
    // Data manipulation - insert and delete support
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        editingProvider?.edititngHandler?(editingStyle, indexPath)
    }
    
    // Data manipulation - reorder / moving support
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        movingProvider?.movingHandler?(sourceIndexPath, destinationIndexPath)
    }
    
}
