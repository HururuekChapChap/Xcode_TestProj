//
//  CustomTabBarController.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2020/12/28.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .blue
        
        let firstVC = UINavigationController(rootViewController: MainViewController())
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "message")
        firstVC.tabBarItem.title = "Recent"
        firstVC.tabBarItem.image = UIImage(systemName: "message.fill")
        
        let dummyView = UIViewController()
        dummyView.view.backgroundColor = .yellow
        dummyView.tabBarItem.title = "Yellow Dummy"
        dummyView.tabBarItem.image = UIImage(systemName: "trash.fill")
        
        viewControllers = [firstVC, dummyView]
        
    }


}
