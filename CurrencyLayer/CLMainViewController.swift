//
//  CLMainViewController.swift
//  CurrencyLayer
//
//  Created by Stefan Buretea on 5/28/17.
//  Copyright © 2017 Stefan Buretea. All rights reserved.
//

import UIKit

class CLMainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var changeCurrencyButton: UIButton!
    
    fileprivate var clickedButton: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        changeCurrencyButton.setImage(UIImage(named: "dollar-symbol.png"), for: .normal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CLMainViewController.addItemsToBasketPressed(sender:)))
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItemsToBasketPressed(sender: UIBarButtonItem) {
        clickedButton = sender
    }
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {
    }
    
    @IBAction func changeCurrencyButtonPressed(_ sender: UIButton) {
        clickedButton = sender
    }
}

extension CLMainViewController: UITableViewDelegate {}

extension CLMainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        switch clickedButton {
        case is UIBarButtonItem:
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.barButtonItem = clickedButton as! UIBarButtonItem
        case is UIButton:
            popoverPresentationController.permittedArrowDirections = .down
            popoverPresentationController.sourceView = clickedButton as! UIButton
            popoverPresentationController.sourceRect = (clickedButton as! UIButton).bounds
        default: ()
        }
    }
}

