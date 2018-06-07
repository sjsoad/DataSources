# DataSources

pod 'SKDataSources'

1. What is data sources?

This is a set of files which can help you with usage of UITableViewDataSource and UICollectionViewDataSource.

2. What features are supported by data source?

2.1 Insert, delete, add, reorder rows in sections
2.2 Insert, delete, add, reorder sections in data source

3. How to use? (Example: TableViewArrayDataSource)

First of all you need to copy files to your project and then follow simple steps:
3.1 Define a variable of your data source it can be empty for first time

var dataSource = TableViewArrayDataSource(with: [])

3.2 Define function that will create your data source from array of items

    private func createDataSource(from list: [Example]) -> TableViewArrayDataSource {
        var items = [DataSourceObjectPresenter]()
        for item in list {
            let dataSourceModel = MainMenuCellPresenter(with: item, cellIdentifier: MainMenuCell.reuseIdentifier)
            items.append(dataSourceModel)
        }
        let section = SectionModel(withItems: items)
        return TableViewArrayDataSource(with: [section])
    }

3.3 Configure table view

    private func setup(tableView: UITableView) {
        let cellNib = UINib(nibName: MainMenuCell.nibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MainMenuCell.reuseIdentifier)
    }

3.4 Create presenter and cell

Make sure your cell conforms all 3 protocols(DataSourceObjectInterface, Reusable, Nibable)
MainMenuCellInterface - protocol that defines your interface methods
Cell class name and xib file name should be the same in order to use the public extension of Reusable and Nibable. In other cases, you should define them in your cell class file

class MainMenuCell: UITableViewCell, DataSourceObjectInterface, Reusable, Nibable, MainMenuCellInterface {
    
    var presenter: MainMenuCellOutput?
    
    // MARK: - DataSourceObjectInterface -
    
    func set(presenter: DataSourceObjectPresenter) {
        self.presenter = presenter as? MainMenuCellOutput
    }
    
    // MARK: - MainMenuCellInterface -
    
    func set(_ title: String?) {
        textLabel?.text = title
    }
    
}

Make sure your presenter conforms DataSourceObjectPresenter

MainMenuCellInterface - protocol that defines your interface methods
MainMenuCellOutput - protocol that defines your presenter methods

protocol MainMenuCellInterface: class {
    
    func set(_ title: String?)
    
}

protocol MainMenuCellOutput {
    
}

class MainMenuCellPresenter: DataSourceObjectPresenter {
    
    private weak var view: MainMenuCellInterface?
    
    private(set) var reuseIdentifier: String
    private(set) var model: Example
    
    init(with objectModel: Example, cellIdentifier: String) {
        self.model = objectModel
        self.reuseIdentifier = cellIdentifier
    }
    
    // MARK: - DataSourceObjectPresenter -
    
    func set(view: UIView) {
        self.view = view as? MainMenuCellInterface
    }
    
    func configure() {
        view?.set(model.title)
    }
    
}

// MARK: - MainMenuCellOutput -

extension MainMenuCellPresenter: MainMenuCellOutput {
    
}

3.5 Implement delegate methods

In our data source editing style method is required, because data source supports reordering, delete and insert events.

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }


4. Options

4.1 Delegate methods for different order options

    // Optional for reordering
    
    func tableView(_ tableView: UITableView,
                   targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                   toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        let sectionsCount = tableView.numberOfSections
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            let rowInSourceSection = sourceIndexPath.section > proposedDestinationIndexPath.section ? 0 : sectionsCount - 1
            return IndexPath(row: rowInSourceSection, section: sourceIndexPath.section)
        } else if proposedDestinationIndexPath.row >= sectionsCount {
            return IndexPath(row: sectionsCount - 1, section: sourceIndexPath.section)
        }
        // Allow the proposed destination.
        return proposedDestinationIndexPath
    }


4.2 Features Provider

Support TableViewRowEditing protocol in order to delete or insert cells. Set isEdititng to true to your UITableView and in delegate method return UITableViewCellEditingStyle - .delete or .insert

var edititngHandler: ((UITableViewCellEditingStyle, IndexPath) -> Void)? {
        return { [weak self] (edititngStyle, indexPath) in
            switch edititngStyle {
            case .delete:
                self?.dataSource.remove(itemAt: indexPath)
                self?.view?.deleteRow(at: indexPath)
            case .insert:
                if let viewModel = self?.newDataSourceModel(for: indexPath) {
                    self?.dataSource.insert(item: viewModel, at: indexPath, handler: { [weak self] (indexPathes) in
                        self?.view?.insertRows(at: indexPathes)
                    })
                }
            case .none:
                print("none")
            }
        }
    }

UI update for delete

    func deleteRow(at indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }

UI update for insert

    func insertRows(at indexPathes: [IndexPath]) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathes, with: .left)
        tableView.endUpdates()
    }

Support TableViewRowMoving protocol in order to move cells. Set isEdititng to true to your UITableView and in delegate method return UITableViewCellEditingStyle - .none

    var canMoveRow: ((IndexPath) -> Bool)? {
        return { [weak self] indexPath in
            return true
        }
    }
    
    var movingHandler: ((IndexPath, IndexPath) -> Void)? {
        return { [weak self] (sourceIndexPath, destinationIndexPath) in
            self?.dataSource.reorderItems(at: sourceIndexPath, and: destinationIndexPath)
        }
    }
