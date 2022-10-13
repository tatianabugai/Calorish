//
//  FoodsViewController.swift
//  Calorish
//
//  Created by admin on 27.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit
import Rswift

protocol ItemsDisplayLogic: AnyObject {
    func displayFoods(viewModel: ItemsViewModel)
    func setTitle(_ title: String)
    func setSegmentedControlTitles(_ titles: [String])
    func displayAlert(model: AlertModel)
}

class ItemsViewController: UIViewController, ItemsDisplayLogic {
    
    var interactor: ItemsBusinessLogic?
    
    private var viewModel: ItemsViewModel?
    
    @IBOutlet private var segmentedControl: UISegmentedControl!
    @IBOutlet private var tableView: UITableView!
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = R.string.localizable.itemsSearchPlaceholder()
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .white
        searchBar.sizeToFit()
        return searchBar
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.plus,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapAddButton))

        segmentedControl.addTarget(self, action: #selector(didChangeSegmentedControl(_:)), for: .valueChanged)
        
        tableView.register(R.nib.itemCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = ItemCell.height
        tableView.estimatedRowHeight = ItemCell.height
        
        interactor?.didTriggerViewReadyEvent()
    }
    
    @objc func didChangeSegmentedControl(_ segmentedControl: UISegmentedControl) {
        interactor?.didTriggerSegmentChangedEvent(index: segmentedControl.selectedSegmentIndex)
    }
    
    func displayFoods(viewModel: ItemsViewModel) {
        navigationItem.largeTitleDisplayMode = viewModel.largeTitleDisplayMode
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setSegmentedControlTitles(_ titles: [String]) {
        
        if titles.count < 2 {
            segmentedControl.isHidden = true
        
        } else {            
            for index in 0...titles.count - 1 {
                segmentedControl.setTitle(titles[index], forSegmentAt: index)
            }
        }
    }
    
    func displayAlert(model: AlertModel) {
        let alertVC = UIAlertController(model: model)       
        present(alertVC, animated: true, completion: nil)
    }
    
    @objc private func didTapAddButton() {
        interactor?.didTapAddButton()
    }
}

extension ItemsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.didTriggerSearchTextChangedEvent(text: searchText)
    }
}

extension ItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.itemCell,
                                                 for: indexPath)
        guard let cellViewModel = viewModel?.cells[indexPath.row] else { fatalError() }
        cell?.setup(with: cellViewModel)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return searchBar
    }
}

extension ItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectRow(at: indexPath)
    }
}

