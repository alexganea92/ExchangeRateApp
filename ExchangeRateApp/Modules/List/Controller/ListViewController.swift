//
//  ListViewController.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 02/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
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
        
        controller.update(.start)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        controller.update(.stop)
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
                self?.title = self?.viewModel.getTitle()
                self?.tableView.reloadData()
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
