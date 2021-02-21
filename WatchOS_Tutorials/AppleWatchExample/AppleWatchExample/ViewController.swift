//
//  ViewController.swift
//  AppleWatchExample
//
//  Created by yoon tae soo on 2021/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtTaskName : UITextField!
    @IBOutlet weak var txtDatePicker : UITextField!
    let datePicker = UIDatePicker()
    
    let watchViewModel = WatchManager.shared
    
    private func showDatePicker(){
        datePicker.datePickerMode = .time
        txtDatePicker.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePcikerValueChanged), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        showDatePicker()
        
        
    }
    
    @objc func datePcikerValueChanged(sender : UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        txtDatePicker.text = dateFormatter.string(from: sender.date)
    }

    @IBAction func buttonTap(_ sender: Any) {
       
        if let vaildSession = self.watchViewModel.watchSession , vaildSession.isReachable {
            
            let data : [String : Any] = [
                
                "taskName" : txtTaskName.text ?? "",
                "finishedTime" : txtDatePicker.text ?? ""
            
            ]
            
            vaildSession.sendMessage(data, replyHandler: nil, errorHandler: nil)
            
            print("send : \(data)")
            
        }
        else{
            
            print(self.watchViewModel.watchSession)
        }
        
        
//        WatchManager.shared.sendParamsToWatch(dict: [
//
//            "taskName" : txtTaskName.text ?? "",
//            "finishedTime" : txtDatePicker.text ?? ""
//
//        ])
    }
    
}

