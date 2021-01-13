//
//  Service.swift
//  Alamofire_Tutorial
//
//  Created by yoon tae soo on 2021/01/13.
//

import Foundation
import Alamofire

struct postsData : Codable{
    
    let userId : Int
    let id : Int
    let title : String
    let body : String
    
}

class Service {

    fileprivate var baseURL : String!
        
    
    init(baseUrl : String) {
        
        self.baseURL = baseUrl
        
    }
    
    func getAllJsonData(endPoint : String, query : [String : String]? ,complete : @escaping ([postsData]?) -> Void) {
        
        AF.request(self.baseURL + endPoint,
                   method: .get,
                   parameters: query,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil).response(completionHandler: { resData in
            
            guard let data = resData.data else {
                complete(nil)
                return}
            
            do{
                let result = try JSONDecoder().decode([postsData].self, from: data)
                complete(result)
//                print(result)
            }
            catch{
                print(error.localizedDescription)
                complete(nil)
            }
            
        })
        
    }
    
    
    
}
