//
//  ExchangeTableViewCell.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 02/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import UIKit

class ExchangeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rateLabel: UILabel!
    
    var exchangeObject: ExchangeInfoModel? {
          didSet{
            rateLabel.text = exchangeObject?.information
          }
      }
    
    public static func cellIdentifier() -> String {
           return String(describing: self)
       }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
