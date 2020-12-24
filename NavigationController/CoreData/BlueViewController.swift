//
//  BlueViewController.swift
//  CoreData
//
//  Created by yoon tae soo on 2020/12/24.
//

import UIKit

class BlueViewController: UIViewController {

    let button : UIButton = {
       
        let button = UIButton()
        button.setTitle("클릭 here", for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushNavi), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .blue
        
        navigationItem.title = "Hello world"
    }
    
    override func viewDidLayoutSubviews() {
        
        setbutton()
        
    }
    
    private func setbutton(){
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    @objc private func pushNavi(){
        
        let vc = ViewController()
        vc.getData = "Hello World"
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
