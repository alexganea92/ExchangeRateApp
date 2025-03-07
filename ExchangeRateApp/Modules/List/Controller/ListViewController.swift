//
//  ListViewController.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 02/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: ListViewModel {
        return controller.viewModel
    }
    
    lazy var controller: ListController = {
        return ListController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        initBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        controller.refresh(.start)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        controller.refresh(.stop)
    }
    
    func showMessage(_ string: String) {
        let alert = UIAlertController(title: "Alert", message: string, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func menuPressed(_ sender: Any) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        controller.addAction(UIAlertAction(title: "Setting Screen", style: UIAlertAction.Style.default, handler: { action in
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "SettingViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        controller.addAction(UIAlertAction(title: "History Screen", style: UIAlertAction.Style.default, handler: { action in
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "HistoryViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        controller.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        present(controller, animated: true, completion: nil)
    }
    
    func initBinding(){
        viewModel.isLoading.addObserver { [weak self] (isLoading) in
            self?.activityIndicator.isHidden = !isLoading
            isLoading ?  self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
        
        viewModel.exchangeData.addObserver { [weak self] (rate) in
            if rate.count > 0 {
                self?.title = self?.viewModel.title()
                self?.tableView.reloadData()
            }
        }
        
        viewModel.message.addObserver { [weak self] (message) in
            if let message = message {
                self?.showMessage(message)
            }
        }
    }
}

// MARK: - Table Data Source & Delegate

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeTableViewCell.cellIdentifier(), for: indexPath) as! ExchangeTableViewCell
        cell.exchangeObject = viewModel.objectFor(indexPath)
        
        return cell
    }
}
