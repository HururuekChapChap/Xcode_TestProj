//
//  ViewController.swift
//  NastedScrollView
//
//  Created by yoon tae soo on 2020/10/31.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
        if segue.identifier == "one"{
            print("one connected with ViewController")
            guard let vc = segue.destination as? SampleViewController else {return}
            
            vc.viewModel.updateType(type: .one)
            
        }
        else if segue.identifier == "two"{
            
            print("two connected with ViewController")
            
            guard let vc = segue.destination as? SampleViewController else {return}
            
            vc.viewModel.updateType(type: .two)
            
        }

    }


}

