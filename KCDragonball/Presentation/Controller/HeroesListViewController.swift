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
    private var heroes: [Hero] = []
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
        
        
        NetworkModel.shared.getHeroes { [ weak self ]result in
            switch result {
            case let .success(heroes):
                print(heroes)
                self?.heroes = heroes
                snapshot.appendItems(heroes)
                self?.dataSource?.apply(snapshot)
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
        300
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let hero = heroes[indexPath.row]
        let detailViewController = HeroDetailViewController(hero: hero)
        navigationController?.show(detailViewController, sender: self)
    }
}

