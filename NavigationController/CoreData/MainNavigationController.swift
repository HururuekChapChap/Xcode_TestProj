//
//  MainNavigationController.swift
//  CoreData
//
//  Created by yoon tae soo on 2020/12/24.
//

import UIKit

class MainNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Navigation Contoller")
        
        let vc = BlueViewController()

        self.pushViewController(vc, animated: true)
        
        
    }
    
}
