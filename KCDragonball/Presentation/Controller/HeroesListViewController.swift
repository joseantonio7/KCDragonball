//
//  HeroesListViewController.swift
//  KCDragonball
//
//  Created by José Antonio Aravena on 29-09-24.
//

import UIKit

final class HeroesListViewController: UITableViewController {
    // MARK: - Table View DataSource
    typealias DataSource = UITableViewDiffableDataSource<Int, Hero>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Hero>
    
    // MARK: - Model
    private let heroes: [Hero] = []
    private var dataSource: DataSource?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            UINib(nibName: HeroTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HeroTableViewCell.identifier
        )
        
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, hero in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HeroTableViewCell.identifier,
                for: indexPath
            ) as? HeroTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: hero)
            return cell
        }
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(heroes)
        
        dataSource?.apply(snapshot)
        
        NetworkModel.shared.getHeroes { result in
            switch result {
            case let .success(heroes):
                print(heroes)
            case let .failure(error):
                print(error)
            }
        }

    }
}

// MARK: - Table View Delegate
extension HeroesListViewController {
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        100
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let hero = heroes[indexPath.row]
        //let detailViewController = HouseDetailViewController(house: house, isFavourite: isFavourite)
        //detailViewController.favouriteHouseDelegate = self
        //navigationController?.show(detailViewController, sender: self)
    }
}

