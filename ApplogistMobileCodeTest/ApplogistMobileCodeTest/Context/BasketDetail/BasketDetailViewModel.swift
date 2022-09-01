//
//  BasketDetailViewModel.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 1.09.2022.
//

import Foundation
import UIKit
protocol BasketDetailVMMDelegate: AnyObject {
    func getOrderResponse(order:Order)
    func getErr(err:ErrorModel?)
}

class BasketDetailViewModel {
    var delegate: BasketDetailVMMDelegate?
    func getListReq() {
        ApplogistService.sendData { order in
            self.delegate?.getOrderResponse(order: order)
        } failure: { errorModel in
            self.delegate?.getErr(err: errorModel)
            
        }

    }
}
