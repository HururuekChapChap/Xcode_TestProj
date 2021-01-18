//
//  ViewController.swift
//  Alamofire_Tutorial
//
//  Created by yoon tae soo on 2021/01/13.
//

import UIKit

class ViewController: UIViewController {

    //apiKey : c46ef587d0bb4f20b41fa6c558a38f3f
    //https://newsapi.org
    //naver.com
    //hou**4***
    
    let name : String = ""
    let number : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        let service = Service(baseUrl: "https://jsonplaceholder.typicode.com/")
        
        service.getAllJsonData(endPoint: "posts" , query: nil) { (result) in
            
            if result != nil {
                print(result!)
            }
            
        }
    }
    
    //https://jsonplaceholder.typicode.com/posts


}

