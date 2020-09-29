//
//  SecondViewController.swift
//  SomeDayUseProJ
//
//  Created by yoon tae soo on 2020/09/29.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("두번째 ViewDidLoad 호출")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackBTN(_ sender: UIButton) {
        
        
        dismiss(animated: true, completion: nil)
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("두번째 ViewDidLayoutSubView 호출")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("두번째 viewWillLayoutSubviews 호출")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("두번째 ViewWillApper 호출")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("두번째 viewWillDisAppear 호출")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("두번째 ViewDidDisappear 호출")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("두번째 viewDidAppear 호출")
    }

}
