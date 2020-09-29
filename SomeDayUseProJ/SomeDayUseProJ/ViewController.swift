//
//  ViewController.swift
//  SomeDayUseProJ
//
//  Created by yoon tae soo on 2020/09/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("첫 ViewDidLoad 호출")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ChangeViewBtn(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1) {
            self.mainView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("첫 ViewDidLayoutSubView 호출")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("첫 viewWillLayoutSubviews 호출")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("첫 ViewWillApper 호출")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("첫 viewWillDissAppear 호출")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("첫 ViewDidDisappear 호출")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("첫 viewDidAppear 호출")
    }
    
    


}

