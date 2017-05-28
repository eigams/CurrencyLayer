//
//  CLCurrenciesViewController.swift
//  CurrencyLayer
//
//  Created by Stefan Buretea on 5/28/17.
//  Copyright © 2017 Stefan Buretea. All rights reserved.
//

import Foundation
import UIKit

protocol CLCurrenciesViewControllerDelegate: class {
    func didSelectCurrency(_ controller: CLCurrenciesViewController, currencyRate: [String: Double])
}

class CLCurrenciesViewController: UITableViewController {
    private let CLCurrenciesTableViewCellID = "CLCurrenciesTableViewCell"
    
    private var currencyRate:[String:Double] = [CLCurrency.USD.rawValue: 1]
    
    weak var delegate: CLCurrenciesViewControllerDelegate?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CLCurrenciesTableViewCellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CLCurrency.allValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CLCurrenciesTableViewCellID)
        
        cell?.textLabel?.text = CLCurrency.allValues[indexPath.row].rawValue
        
        return cell ?? UITableViewCell(style: .default, reuseIdentifier: CLCurrenciesTableViewCellID)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CLCurrency.allValues[indexPath.row].conversionRate { rate in
            self.currencyRate = rate
            DispatchQueue.main.async {
                if let r = self.currencyRate["USD\(CLCurrency.allValues[indexPath.row].rawValue)"] {
                    self.delegate?.didSelectCurrency(self, currencyRate: [CLCurrency.allValues[indexPath.row].rawValue: r])
                } else {
                    self.delegate?.didSelectCurrency(self, currencyRate: [CLCurrency.USD.rawValue: 1])
                }
            }
        }
    }
}
