//
//  ViewController.swift
//  push_notification
//
//  Created by yoon tae soo on 2020/11/20.
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

