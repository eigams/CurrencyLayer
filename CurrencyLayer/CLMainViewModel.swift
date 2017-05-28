//
//  CLMainViewModel.swift
//  CurrencyLayer
//
//  Created by Stefan Buretea on 5/28/17.
//  Copyright © 2017 Stefan Buretea. All rights reserved.
//

import Foundation
import UIKit


class CLMainViewModel : NSObject, UITableViewDataSource {
    private let CLBasketTableViewCellID = "CLBasketTableViewCell"
    private (set) var items:[CLBasketItem] = []
    private (set) var rate: Double = 1 {
        didSet {
            if rate != oldValue {
                displayPrice = totalPrice*rate
            }
        }
    }
    private var totalPrice: Double = 0
    private (set) var displayPrice: Double = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CLBasketTableViewCellID) ?? UITableViewCell(style: .value1, reuseIdentifier: CLBasketTableViewCellID)
        
        cell.textLabel?.text = items[indexPath.row].rawValue
        cell.detailTextLabel?.text = "\(items[indexPath.row].price) $"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func addBasketItem(_ item: CLBasketItem) {
        items.append(item)
    }
    
    func changeRate(to changedRate:Double) {
        rate = changedRate
    }
    
    func updateDisplayPrice() {
        totalPrice = items.reduce(0, {$0 + $1.price})
        displayPrice = totalPrice*rate
    }
}
