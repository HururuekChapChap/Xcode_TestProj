//
//  ViewController.swift
//  watchNotification
//
//  Created by yoon tae soo on 2021/03/01.
//

import UIKit

class ViewController: UIViewController {

    let notification = NotificationCenter.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        notification.generateNotification()
    }


}

