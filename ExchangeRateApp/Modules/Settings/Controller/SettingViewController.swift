//
//  SettingViewController.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    var viewModel: SettingViewModel {
        return controller.viewModel
    }
    
    lazy var controller: SettingController = {
        return SettingController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateRefreshInterval()
        
        initBinding()
        controller.update()
    }
    
    func initBinding(){
        viewModel.isLoading.addObserver { [weak self] (isLoading) in
            self?.currencyButton.isEnabled = !isLoading
            self?.currencyButton.setTitle(Default.currencyBase, for: .normal)
        }
    }
    
    func updateCurrency(){
        currencyButton.setTitle(Default.currencyBase, for: .normal)
    }
    
    func updateRefreshInterval(){
        refreshButton.setTitle(viewModel.currentRefreshInterval(), for: .normal)
    }
    
    @IBAction func currencyPressed(_ sender: Any) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        for item in viewModel.currencyOptions {
            controller.addAction(UIAlertAction(title: item.name, style: UIAlertAction.Style.default, handler: { action in
                Default.currencyBase = action.title!
                self.controller.update()
            }))
        }
        controller.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        for item in viewModel.refreshIntervals {
            controller.addAction(UIAlertAction(title: item, style: UIAlertAction.Style.default, handler: { action in
                Default.refreshInterval = TimeInterval(Int(action.title!)!)
                self.updateRefreshInterval()
            }))
        }
        controller.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        present(controller, animated: true, completion: nil)
    }
    
}
