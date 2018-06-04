//
//  CollectionViewArrayDataSource.swift
//  New Data Source
//
//  Created by Sergey on 18.10.17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

open class CollectionViewArrayDataSource: NSObject, ArrayDataSourceRepresentable {
    
    private(set) public var sections: [SectionModel] = []
    private(set) var movingProvider: CollectionViewRowMoving?
    
    public init(with sections: [SectionModel], movingProvider: CollectionViewRowMoving? = nil) {
        self.sections = sections
        self.movingProvider = movingProvider
    }
    
    // MARK: - DataSourceAppendable -
    
    public func append(newSections: [SectionModel], handler: DataSourceChangeHandler?) {
        guard !newSections.isEmpty else { return }
        let lastIndex = sections.count - 1
        self.sections.append(contentsOf: newSections)
        let diff = Array(lastIndex + 1...lastIndex + newSections.count)
        handler?(diff)
    }
    
    public func append(newSection: SectionModel, handler: DataSourceChangeHandler?) {
        self.sections.append(newSection)
        let diff = [self.sections.count - 1]
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
        let diff = Array(index...index + sections.count - 1)
        handler?(diff)
    }
    
    public func insert(newSection: SectionModel, at index: Int, handler: DataSourceChangeHandler?) {
        guard sections.indices.contains(index) || index == 0 else { return }
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
    
    // MARK: - Private
    
    private func model(for indexPath: IndexPath, kind: String) -> DataSourceObjectPresenter? {
        guard sections.indices.contains(indexPath.section) else { return nil }
        let sectionModel = sections[indexPath.section]
        if kind == UICollectionElementKindSectionHeader {
            guard let header = sectionModel.header,
                let model = header.headerModel else { return nil }
            return model
        } else if kind == UICollectionElementKindSectionFooter {
            guard let footer = sectionModel.footer,
                let model = footer.footerModel else { return nil }
            return model
        }
        return nil
    }
    
}

extension CollectionViewArrayDataSource: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return numberOfItemsInSection(sectionIndex: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let presenter = itemAtIndexPath(indexPath: indexPath) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: presenter.reuseIdentifier,
                                                          for: indexPath)
            if let configurableCell = cell as? ConfigurableCell {
                configurableCell.configure()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections()
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let presenter = self.model(for: indexPath, kind: kind) else { return UICollectionReusableView() }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: presenter.reuseIdentifier,
                                                                   for: indexPath)
        if let configurableView = view as? ConfigurableView {
            configurableView.configure()
        }
        return view
    }
    
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return movingProvider?.canMoveRow?(indexPath) ?? false
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        movingProvider?.movingHandler?(sourceIndexPath, destinationIndexPath)
    }
    
}
