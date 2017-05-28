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
    
    fileprivate let viewModel = CLMainViewModel()
    fileprivate var clickedButton: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        changeCurrencyButton.setImage(UIImage(named: "dollar-symbol.png"), for: .normal)
        currencyLabel.text = CLCurrency.USD.rawValue
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CLMainViewController.addItemsToBasketPressed(sender:)))
        tableView.dataSource = viewModel
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItemsToBasketPressed(sender: UIBarButtonItem) {
        clickedButton = sender
        let basketViewController = CLBasketViewController(style: .plain)
        basketViewController.delegate = self
        basketViewController.modalPresentationStyle = .popover
        basketViewController.preferredContentSize = CGSize(width: 200, height: 175)
        basketViewController.popoverPresentationController?.delegate = self
        
        present(basketViewController, animated: true, completion: nil)
    }
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        viewModel.updateDisplayPrice()
        priceLabel.text = String(format:"%.2f",viewModel.displayPrice)        
    }
    
    @IBAction func changeCurrencyButtonPressed(_ sender: UIButton) {
        clickedButton = sender
        let currenciesViewController = CLCurrenciesViewController(style: .plain)
        currenciesViewController.delegate = self
        currenciesViewController.modalPresentationStyle = .popover
        currenciesViewController.preferredContentSize = CGSize(width: 70, height: 175)
        currenciesViewController.popoverPresentationController?.delegate = self
        
        present(currenciesViewController, animated: true, completion: nil)
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

extension CLMainViewController: CLBasketViewControllerDelegate {
    func didSelectItem(_ viewController: CLBasketViewController, item: CLBasketItem) {
        viewModel.addBasketItem(item)
        presentedViewController?.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}

extension CLMainViewController: CLCurrenciesViewControllerDelegate {
    func didSelectCurrency(_ controller: CLCurrenciesViewController, currencyRate: [String: Double]) {
        viewModel.changeRate(to: currencyRate.first?.value ?? 1)
        self.presentedViewController?.dismiss(animated: true, completion: nil)
        currencyLabel.text = currencyRate.first?.key
        priceLabel.text = String(format:"%.2f",viewModel.displayPrice)
    }
}
