//
//  MainViewController.swift
//  PageViewController
//
//  Created by yoon tae soo on 2020/08/15.
//  Copyright © 2020 yoon tae soo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    
    var btnLists : [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet{
            changeBtnColor()
            print(currentIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtnList()
        // Do any additional setup after loading the view.
    }
    
    func setBtnList(){
        firstBtn.tintColor = .orange
        btnLists.append(firstBtn)
        btnLists.append(secondBtn)
        btnLists.append(thirdBtn)
        
    }
    
    func changeBtnColor(){
        
        for (index, element) in btnLists.enumerated(){
            
            if index == currentIndex{
                element.tintColor = .orange
            }
            else{
                element.tintColor = .systemBlue
            }
            
        }
        
    }
    
    
    var pageViewController : PageViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PageViewController" {
            print("Connected")
            guard let vc = segue.destination as? PageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
            
        }
        
    }
    

    @IBAction func firstBtn(_ sender: Any) {
    
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    @IBAction func secondeBtn(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    @IBAction func thirdBtn(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 2)
    }
}
