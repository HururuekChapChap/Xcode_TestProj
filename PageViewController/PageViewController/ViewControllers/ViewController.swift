//
//  ViewController.swift
//  PageViewController
//
//  Created by yoon tae soo on 2020/08/15.
//  Copyright © 2020 yoon tae soo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("GreenViewController")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           print("GreenViewController Did Appear")
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           
            print("GreenViewController Did DisAppear")
           
       }
}

