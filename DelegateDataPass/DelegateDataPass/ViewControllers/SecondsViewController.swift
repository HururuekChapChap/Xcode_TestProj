//
//  SecondsViewController.swift
//  DelegateDataPass
//
//  Created by yoon tae soo on 2020/11/02.
//

import UIKit


protocol sendDataDelegate : class {
    
    func sendDatafunction(input : String)
    
}


class SecondsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var tempString : String = ""
    
    
    weak var delegate : sendDataDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldDelegate()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        
        titleLabel.text = tempString

    }
    
    
    func updateTitleLabel(input : String){
        tempString = input
    }
    
    @IBAction func backToVcBtn(_ sender: Any) {
        
        if textField.text != "" && delegate != nil{
            delegate?.sendDatafunction(input: textField.text!)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}

extension SecondsViewController : UITextFieldDelegate {
    
    func setTextFieldDelegate(){
        self.textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
    }
    
}
