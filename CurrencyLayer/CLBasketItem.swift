//
//  CLBasketItem.swift
//  CurrencyLayer
//
//  Created by Stefan Buretea on 5/28/17.
//  Copyright © 2017 Stefan Buretea. All rights reserved.
//

import Foundation

enum CLBasketItem: String {
    case peas, eggs, milk, beans
    
    var price: Double {
        switch self {
            case .peas:
                return 0.95
            case .eggs:
                return 2.1
            case .milk:
                return 1.3
            case .beans:
                return 0.73
        }
    }
    
    static let allValues:[CLBasketItem] = [.peas, .eggs, .milk, .beans]
}

