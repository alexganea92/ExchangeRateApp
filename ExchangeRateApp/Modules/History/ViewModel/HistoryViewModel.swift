//
//  HistoryViewModel.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 04/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation
import Charts

class HistoryViewModel{
    let exchangeDataArray = Observable<[Rate]>(value: [])
    let roundUp: (LineChartData) -> Double = { (chartData) in
        return chartData.getYMax().rounded(.up)
    }
    
    /**
     Get processed currency data as history
     
     - returns:
     Object to be used as feed data entry for the chart
     */
    func processData() -> LineChartData{
        var dictionaryCurrencies = [String:Array<ChartDataEntry>]()
        
        for rate in exchangeDataArray.value {
            for currency in rate.currencyArray{
                
                var currentHistoryCurrencyArray = dictionaryCurrencies[currency.name] ?? []
                
                let date = Helper.sharedInstance.dateFormatter.date(from: rate.date)
                let timeInterval = date?.timeIntervalSince1970
                
                currentHistoryCurrencyArray.append(ChartDataEntry(x: timeInterval!, y: currency.value.doubleValue))
                
                dictionaryCurrencies[currency.name] = currentHistoryCurrencyArray
            }
        }
        
        var chartSets: [LineChartDataSet] = []
        
        for (key, value) in dictionaryCurrencies {
            let sortedValues = value.sorted(by: { $0.x < $1.x })
            let set = LineChartDataSet(entries: sortedValues, label: key)
            set.setColor(UIColor.random)
            set.setCircleColor(.blue)
            set.lineWidth = 3
            set.circleRadius = 6
            set.valueFont = .systemFont(ofSize: 9)
            
            chartSets.append(set)
        }
        
        let chartData = LineChartData(dataSets: chartSets)
        chartData.setDrawValues(true)
        
        return chartData
    }
}
