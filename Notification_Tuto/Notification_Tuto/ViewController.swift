//
//  ViewController.swift
//  Notification_Tuto
//
//  Created by yoon tae soo on 2020/11/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var token : NSObjectProtocol?
    
    
    //노티피케이션이 한번만 호출
    override func viewDidLoad() {
        
        print("ViewController Loaded")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        token = NotificationCenter.default.addObserver(forName: .dateNotification, object: nil, queue: OperationQueue.main) { (notification) in
            
            let viewController = notification.object as! ThridViewController
            let date = notification.userInfo?["date"] as! String
            
            print("First View Yes \(date)")
            
            let inputDateFormate = viewController.inputFormate.date(from: date)!
            let outputDateFormate = viewController.outputFormate.string(from: inputDateFormate)

            self.updateUI(text: outputDateFormate)
        }
        
        //ViewDidLoad() forcly
//        let vc = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
//        let _ = vc.view
        
    }
    
    func updateUI(text : String){
        label.text = text
    }
    


}

