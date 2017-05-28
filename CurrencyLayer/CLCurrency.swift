//
//  CLCurrency.swift
//  CurrencyLayer
//
//  Created by Stefan Buretea on 5/28/17.
//  Copyright © 2017 Stefan Buretea. All rights reserved.
//

import Foundation
import Alamofire

enum CLCurrency: String {
    case USD, EUR, CHF, GBP
    
    private func getConversionRate(for currency: CLCurrency, completion: @escaping ([String:Double]) -> Void) {
        guard currency != .USD else {
            completion([CLCurrency.USD.rawValue: 1])
            return
        }
        
        Alamofire.request("http://apilayer.net/api/live", parameters: ["access_key":"2f80952bbf8b17a4df6187bd0e92a2f7",
                                                                       "currencies": currency.rawValue,
                                                                       "format": "1"])
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching data: \(String(describing: response.result.error))")
                    completion([CLCurrency.USD.rawValue: 1])
                    return
                }
                
                guard let responseJSON = response.result.value as? [String: Any],
                    let success = responseJSON["success"] as? Bool, success == true,
                    let quotes = responseJSON["quotes"] as? [String: Double] else {
                        completion([CLCurrency.USD.rawValue: 1])
                        return
                }
                
                completion(quotes)
        }
    }

    func conversionRate(completion: @escaping ([String:Double]) -> Void) {
        switch self {
            case .EUR, .CHF, .GBP:
                getConversionRate(for: self, completion: completion)
            default:
                completion([CLCurrency.USD.rawValue: 1])
        }
    }
    
    static let allValues:[CLCurrency] = [.USD, .EUR, .CHF, .GBP]
}
