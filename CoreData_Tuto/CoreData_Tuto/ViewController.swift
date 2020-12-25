//
//  ViewController.swift
//  CoreData_Tuto
//
//  Created by yoon tae soo on 2020/12/24.
//

import UIKit

class ViewController: UIViewController {

    let imageView : UIImageView = {
       
        let image = UIImage(named: "Icon.png")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white

        setImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let nextView = UINavigationController(rootViewController: TableViewController())
            nextView.navigationBar.prefersLargeTitles = true
            nextView.modalTransitionStyle = .crossDissolve
            nextView.modalPresentationStyle = .fullScreen
            self.present(nextView, animated: true, completion: nil)
            
        }
        
    }
    
    private func setImageView(){
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        
    }

}

