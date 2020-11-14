//
//  SecondViewController.swift
//  Notification_Tuto
//
//  Created by yoon tae soo on 2020/11/14.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var token : NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        print("SecondViewController Load")
        
        token = NotificationCenter.default.addObserver(forName: .dateNotification, object: nil, queue: OperationQueue.main) { (notification) in
        
            //객체에 대한 사용
            let viewController = notification.object as! ThridViewController
            //userinfo로 값을 사용 할 때 사용
            let date = notification.userInfo?["date"] as! String
            
            print("Second View Yes \(date)")
            
            let inputDateFormate = viewController.inputFormate.date(from: date)!
            let outputDateFormate = viewController.outputFormate.string(from: inputDateFormate)

            self.updateUI(text: outputDateFormate)
        }
        
        
        // Do any additional setup after loading the view.
    
    }
    
    //처음에는 한번만 호출 되다가 나중에 호출하면 여러번 호출 됨,,,
    //이유는 모르겠음,,, 따라서 Notification은 ViewDidLoad에 위치 시키는게 맞는 듯
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewDIdAppear")
        
//        token = NotificationCenter.default.addObserver(forName: .dateNotification, object: nil, queue: OperationQueue.main) { (notification) in
//
//            //객체에 대한 사용
//            let viewController = notification.object as! ThridViewController
//            //userinfo로 값을 사용 할 때 사용
//            let date = notification.userInfo?["date"] as! String
//
//            print("Second View Yes \(date)")
//
//            let inputDateFormate = viewController.inputFormate.date(from: date)!
//            let outputDateFormate = viewController.outputFormate.string(from: inputDateFormate)
//
//            self.updateUI(text: outputDateFormate)
//        }
//
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//        if let token = token{
//            NotificationCenter.default.removeObserver(token)
//        }
        
    }
    
    func updateUI(text : String){
        label.text = text
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
