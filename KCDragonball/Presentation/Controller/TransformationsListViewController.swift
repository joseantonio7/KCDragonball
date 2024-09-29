//
//  TransformationsListViewController.swift
//  KCDragonball
//
//  Created by José Antonio Aravena on 29-09-24.
//

import UIKit

final class TransformationsListViewController: UITableViewController {
        // MARK: - Table View DataSource
        typealias DataSource = UITableViewDiffableDataSource<Int, Transformation>
        typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Transformation>
        
        // MARK: - Model
        private var transformations: [Transformation] = []
        private var dataSource: DataSource?
        private var hero : Hero
    
        // MARK: - init
    init(hero: Hero) {
            self.hero = hero
            super.init(nibName: nil, bundle: nil)
        }
    
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            tableView.register(
                UINib(nibName: TransformationTableViewCell.identifier, bundle: nil),
                forCellReuseIdentifier: TransformationTableViewCell.identifier
            )
            
            dataSource = DataSource(tableView: tableView) { tableView, indexPath, transformation in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: TransformationTableViewCell.identifier,
                    for: indexPath
                ) as? TransformationTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: transformation)
                return cell
            }
            
            tableView.dataSource = dataSource
            tableView.delegate = self
            
            var snapshot = Snapshot()
            snapshot.appendSections([0])
            
            
            NetworkModel.shared.getTransformations(for: hero) { [ weak self ] result in
                switch result {
                case let .success(transformations):
                    print(transformations)
                    self?.transformations = transformations
                    snapshot.appendItems(transformations)
                    self?.dataSource?.apply(snapshot)
                case let .failure(error):
                    print(error)
                }
            }

        }
    }

    // MARK: - Table View Delegate
    extension TransformationsListViewController {
        override func tableView(
            _ tableView: UITableView,
            heightForRowAt indexPath: IndexPath
        ) -> CGFloat {
            300
        }
        
        override func tableView(
            _ tableView: UITableView,
            didSelectRowAt indexPath: IndexPath
        ) {
            // TODO: - transformation detail
 //           let transformation = transformations[indexPath.row]
//            let detailViewController = TransformationDetailViewController(transformation: transformation)
 //           navigationController?.show(detailViewController, sender: self)
        }
}

