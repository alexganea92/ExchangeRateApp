//
//  HistoryViewController.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import UIKit
import Charts

class HistoryViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var chartView: LineChartView!
    
    var viewModel: HistoryViewModel {
        return controller.viewModel
    }
    
    lazy var controller: HistoryController = {
        return HistoryController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self
        chartView.xAxis.valueFormatter = DateValueFormatter()
        chartView.xAxis.labelCount = 2
        
        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: chartView.xAxis.valueFormatter!)
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        chartView.leftAxis.axisMinimum = 0
        
        initBinding()
        controller.update()
    }
    
    func initBinding(){
        viewModel.exchangeDataArray.addObserver { [weak self] (rates) in
            self?.chartView.data = self?.viewModel.processData()
            self?.chartView.leftAxis.axisMaximum = self?.viewModel.roundUp(self?.chartView.data as! LineChartData) ?? 0
        }
    }
}
