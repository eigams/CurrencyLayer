//
//  CLBasketViewController.swift
//  CurrencyLayer
//
//  Created by Stefan Buretea on 5/28/17.
//  Copyright © 2017 Stefan Buretea. All rights reserved.
//

import Foundation
import UIKit


protocol CLBasketViewControllerDelegate: class {
    func didSelectItem(_ viewController: CLBasketViewController, item: CLBasketItem)
}


class CLBasketViewController: UITableViewController {
    private let CLBasketTableViewCellID = "CLBasketTableViewCell"
    
    weak var delegate: CLBasketViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CLBasketItem.allValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CLBasketTableViewCellID) ?? UITableViewCell(style: .value1, reuseIdentifier: CLBasketTableViewCellID)
        
        cell.textLabel?.text = CLBasketItem.allValues[indexPath.row].rawValue
        cell.detailTextLabel?.text = "\(CLBasketItem.allValues[indexPath.row].price) $"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(self, item: CLBasketItem.allValues[indexPath.row])
    }
}
