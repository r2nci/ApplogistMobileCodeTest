//
//  ErrorModel.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 30.08.2022.
//

import Foundation

open class ErrorModel
{
    var description: String = "Bir Hata Oluştu"
    
    init(error: Error?)
    {
        if let error = error
        {
            self.description = error.localizedDescription
        }
    }
}
