//
//  CLMainViewModelTests.swift
//  CurrencyLayer
//
//  Created by Stefan Buretea on 5/28/17.
//  Copyright © 2017 Stefan Buretea. All rights reserved.
//

import XCTest

class CLMainViewModelTests: XCTestCase {
    var viewModel = CLMainViewModel()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testAddBasketItem() {
        viewModel.addBasketItem(CLBasketItem.beans)
        
        XCTAssert(viewModel.items.count == 1)
    }
    
    func testChangeRate() {
        XCTAssert(viewModel.rate == 1)
        viewModel.changeRate(to: 2)
        XCTAssert(viewModel.rate == 2)
    }
    
    func testUpdatePrice() {
        viewModel.addBasketItem(CLBasketItem.beans)
        XCTAssert(viewModel.displayPrice == 0)
        viewModel.updateDisplayPrice()
        XCTAssert(viewModel.displayPrice == CLBasketItem.beans.price)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
