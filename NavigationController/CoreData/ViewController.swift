//
//  ViewController.swift
//  CoreData
//
//  Created by yoon tae soo on 2020/12/24.
//

import UIKit

class ViewController: UIViewController {

    var getData : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .yellow
        
        print(getData ?? "없습니다")
        
        
        
    }


}

