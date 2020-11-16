//
//  TabBarViewController.swift
//  Notification_Tuto
//
//  Created by yoon tae soo on 2020/11/14.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Call ViewController at once
        for vc in self.viewControllers ?? [] {

            if let tabView = vc as? UITabBarController , let root = tabView.viewControllers?.first {

                let _ = root.view

            }
            else{

                let _ = vc.view

            }

        }
        
        // Do any additional setup after loading the view.
    }


}
