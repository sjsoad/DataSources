//
//  CollectionViewArrayDataSource.swift
//  DataSources
//
//  Created by Sergey on 14.09.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

open class CollectionViewArrayDataSource: ArrayDataSource, CollectionViewArrayDataSourceRepresentable {

    private var movingProvider: RowMoving?
    
    public init(with sections: [SectionRepresentable] = [], movingProvider: RowMoving? = nil) {
        super.init(with: sections)
        self.movingProvider = movingProvider
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(in: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let presenter: PresenterType = item(at: indexPath) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: presenter.reuseIdentifier, for: indexPath)
            guard let interface = cell as? ViewType else { return UICollectionViewCell() }
            interface.set(presenter: presenter)
            presenter.set(view: interface)
            presenter.configure()
            return cell
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        guard let presenter = presenter(for: indexPath, kind: kind) else { return UICollectionReusableView() }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: presenter.reuseIdentifier, for: indexPath)
        guard let interface = view as? ViewType else { return UICollectionReusableView() }
        interface.set(presenter: presenter)
        presenter.set(view: interface)
        presenter.configure()
        return view
    }
    
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return movingProvider?.canMoveRow?(indexPath) ?? false
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        movingProvider?.movingHandler?(sourceIndexPath, destinationIndexPath)
    }
    
    // MARK: - Private
    
    private func presenter(for indexPath: IndexPath, kind: String) -> PresenterType? {
        guard sections.indices.contains(indexPath.section) else { return nil }
        let section = sections[indexPath.section]
        if kind == UICollectionView.elementKindSectionHeader {
            return section.header
        } else if kind == UICollectionView.elementKindSectionFooter {
            return section.footer
        }
        return nil
    }
    
}
