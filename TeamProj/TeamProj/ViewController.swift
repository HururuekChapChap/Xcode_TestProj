//
//  ViewController.swift
//  TeamProj
//
//  Created by yoon tae soo on 2020/11/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var 쇼트_알람: UIButton!
    @IBOutlet weak var 노말_알람: UIButton!
    @IBOutlet weak var 파워_알람: UIButton!
    
    var Buttons : [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setButtons()
    }
    
    
    func setButtons() {
        
        Buttons.append(쇼트_알람)
        Buttons.append(노말_알람)
        Buttons.append(파워_알람)
        
    }
    
    @IBAction func 쇼트_펑크(_ sender: UIButton) {
        
        changeColor(changeIndex: 0)
        
    }
    @IBAction func 노말_펑크(_ sender: UIButton) {
        
        changeColor(changeIndex: 1)
        
    }
    @IBAction func 파워_펑크(_ sender: UIButton) {
     
        changeColor(changeIndex: 2)
        
    }
    
    func changeColor(changeIndex : Int){
        
        for (index, element) in Buttons.enumerated(){
            
            if index == changeIndex {
                print("select index is \(changeIndex)")
                element.isSelected = true
                element.setTitleColor(.blue, for: .selected)
                
            }
            else{
                    
                if element.isSelected {
                    
                    element.isSelected = false
                    element.setTitleColor(.black, for: .normal)
                    
                }
                
            }
            
            
        }
        
    }
    

}

