//
//  DateValueFormatter.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 05/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation
import Charts


public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
