//
//  RecipesViewController.swift
//  Calorish
//
//  Created by admin on 10.06.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

protocol RecipeDisplayLogic: AnyObject {
    
    func setTitle(with title: String)
    func setDoneButtonEnabled(_ isEnabled: Bool)
    func setView(with viewModel: RecipeViewModel)
}

class RecipeViewController: UIViewController, RecipeDisplayLogic {
    
    var interactor: RecipeBusinessLogic?
    
    @IBOutlet private var tableView: UITableView!
    private let tableHeaderView = RecipeHeaderView()
    
    private var viewModel: RecipeViewModel?
    
    private lazy var doneButton: UIBarButtonItem = UIBarButtonItem(title: R.string.localizable.commonDone(),
                                                       style: .done,
                                                       target: self,
                                                               action: #selector(didTapDoneButton))
    
    private lazy var addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                  target: self,
                                                                  action: #selector(didTapAddButton))
   
    private lazy var cancelButton: UIBarButtonItem = UIBarButtonItem(title: R.string.localizable.commonCancel(),
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(didTapCancelButton))

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItems = [doneButton, addButton]
        navigationItem.leftBarButtonItem = cancelButton

        view.backgroundColor = .systemGray6
        
        tableHeaderView.frame = CGRect(origin: CGPoint.zero,
                                       size: CGSize(width: tableView.frame.width,
                                                    height: RecipeHeaderView.height))
        
        tableHeaderView.nameTextFieldView.addTarget(self, action: #selector(nameChanged(_:)), controlEvent: .editingChanged)
        tableHeaderView.nameTextFieldView.keyboardType = .default
        
        tableView.tableHeaderView = tableHeaderView
        tableView.register(R.nib.mealCell)
        tableView.rowHeight = MealCell.height
        tableView.estimatedRowHeight = MealCell.height
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        
        interactor?.didTriggerViewReadyEvent()
    }
    
    @objc private func didTapDoneButton() {
        interactor?.didTapDoneButton()
    }
    
    @objc private func didTapAddButton() {
        interactor?.didTapAddButton()
    }
    
    @objc private func didTapCancelButton() {
        interactor?.didTapCancelButton()
    }
    
    @objc private func nameChanged(_ textField: UITextField) {
        interactor?.didTriggerNameChangedEvent(textField.text ?? "")
    }
    
    func setTitle(with title: String) {
        self.title = title
    }
    
    func setView(with viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        tableHeaderView.setup(with: viewModel.header)
        tableView.reloadData()
    }
    
    func setDoneButtonEnabled(_ isEnabled: Bool) {
        doneButton.isEnabled = isEnabled
    }
}


extension RecipeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.table.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mealCell,
                                                 for: indexPath)
        guard let cellViewModel = viewModel?.table.cellAt(indexPath) else { fatalError() }
        cell?.setup(with: cellViewModel)
        return cell ?? UITableViewCell()
    }
}

extension RecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectRow(at: indexPath)
    }
}
