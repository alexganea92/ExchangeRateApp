//
//  Protocols.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 06/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

protocol Updatable {
    func update()
}

protocol ViewModel {
    var isLoading: Observable<Bool> {get set}
    var exchangeData: Observable<[Rate]> {get set}
    var message: Observable<String> {get set}
}
