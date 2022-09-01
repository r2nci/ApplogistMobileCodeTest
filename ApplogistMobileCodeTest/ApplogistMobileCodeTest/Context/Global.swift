//
//  Global.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 30.08.2022.
//

import Foundation
class Global {
    static let shared = Global()
    var itemList: [ItemListModel] = []
    var totalAmount:Double {
        var total : Double = 0.0
        for item in itemList {
            total += item.price ?? 0.0
        }
        return total
    }
    
    var totalProduct:Int {
        var total: Int = 0
        for item in itemList {
            total += item.amount
        }
        return total
    }
}
