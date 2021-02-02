//
//  ViewController.swift
//  FullScreenCamera
//
//  Created by yoon tae soo on 2020/11/24.
//

import UIKit

class ViewController: UIViewController {

    let samepleView : UIView = {
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        
        return view
    }()
    
    let imageView : UIImageView = {
       
        let image = #imageLiteral(resourceName: "ic_photo_camera")
        let imageView = UIImageView(image: image)
        
        return imageView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }


}

