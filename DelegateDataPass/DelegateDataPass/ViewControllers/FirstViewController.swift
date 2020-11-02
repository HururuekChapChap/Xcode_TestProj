//
//  FirstViewController.swift
//  DelegateDataPass
//
//  Created by yoon tae soo on 2020/11/02.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldDelegate()
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Segue"{
            
            guard let vc = segue.destination as? SecondsViewController else {return}
            
            vc.updateTitleLabel(input: textField.text!)
            vc.delegate = self //내가 너의 일을 대신해줄게
            
        }
        
        
    }
    
    @IBAction func sendDatabtn(_ sender: Any) {
        
        if textField.text != ""{
        
        performSegue(withIdentifier: "Segue", sender: nil)
            
        }
    }
    
}

extension FirstViewController : UITextFieldDelegate {
    
    func setTextFieldDelegate(){
        self.textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
}

extension FirstViewController : sendDataDelegate {
    
    func sendDatafunction(input: String) {
        titleLabel.text = input
    }

}
