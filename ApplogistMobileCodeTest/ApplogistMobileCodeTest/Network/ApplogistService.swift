//
//  ApplogistService.swift
//  ApplogistMobileCodeTest
//
//  Created by Ramazan ikinci on 30.08.2022.
//

import Foundation
class ApplogistService: BaseService {
    
    static var baseUrl : String {
        get {
            return "https://desolate-shelf-18786.herokuapp.com/"
        }
    }
    
    static func getList(success: @escaping (_ itemList: [ItemListModel]) -> Void, failure: @escaping (_ errorModel: ErrorModel?) -> Void) -> Void {
        let url = baseUrl + "list"
        
        get(url: url, success: { (responseData) in
            
            guard let baseResponse = responseData else {
                failure(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseModel: [ItemListModel] = try decoder.decode([ItemListModel].self, from: baseResponse)
                success(responseModel)
            }
            catch {
                failure(ErrorModel.init(error: error))
            }
            
        }) { (error) in
            failure(error)
        }
    }
    
}
