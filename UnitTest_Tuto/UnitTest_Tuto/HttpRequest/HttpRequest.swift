//
//  HttpRequest.swift
//  UnitTest_Tuto
//
//  Created by yoon tae soo on 2020/11/05.
//

import Foundation


struct Info : Codable {
    
    let frameWork : String
    let version : Int
    
}

enum ApiError : String, Error{
    
    case networkInvaild = "네트워크 연결 오류"
    case statuseError = "상태 오류"
    case decodeError = "해독 중 오류d"
}


class HttpRequest {
    
    
    func makeUrl(url : String) -> URL? {
        
        let url = URLComponents(string: url)?.url
        
        return url
    }
    
    func getInfoData(url : URL? , completeHandler : @escaping (Result<[Info],ApiError>) -> ()) {
        
        guard let url = url else {
            completeHandler(.failure(.networkInvaild))
            
            return
            
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        excute(request: request, completeHandelr: completeHandler)
        
    }
    
   private func excute(request : URLRequest , completeHandelr : @escaping (Result<[Info],ApiError>) -> ()) {
        
        URLSession.shared.dataTask(with: request) { (data, res, err) in
                
            
            guard let statusCode = (res as? HTTPURLResponse)?.statusCode else {
                completeHandelr(.failure(.statuseError))
                return
                
            }
            
            guard (200..<300).contains(statusCode) else {
                completeHandelr(.failure(.statuseError))
                return}
            
            guard let responseData = data else {
                completeHandelr(.failure(.networkInvaild))
                return
            }
            
            do{
               
                let infoData = try JSONDecoder().decode([Info].self, from: responseData)
                
                completeHandelr(.success(infoData))
                
            }
            catch let error {
                print(error.localizedDescription)
                completeHandelr(.failure(.decodeError))
            }
            
        }.resume()
        
        
    }
    
    
}
