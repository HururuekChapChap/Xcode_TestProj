//
//  ViewController.swift
//  ShareExtension102
//
//  Created by yoon tae soo on 2020/12/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
          print("InAppear")
         let savedata =  UserDefaults.init(suiteName: "group.TeamProj.ShareExtension102.ShareEx102")
//         print("urlData \(String(describing: savedata?.value(forKey: "urlData") as! URL))")
        
//        if let url =  savedata?.string(forKey: "urlData"){
//
//            name.text = String(describing: url)
//            print(url)
//        }
//
        
        if let allData = savedata?.object(forKey: "urlData") {
            
            if let arrayList = allData as? NSArray{
                print(arrayList)
                
                name.text = "\(arrayList)"
            }
            
        }
        
        savedata?.removeObject(forKey: "urlData")
        
        
//         if let url = savedata?.value(forKey: "urlData"){
//                         print("Available Data")
////            let data = ((savedata?.value(forKey: "img")as! NSDictionary).value(forKey: "imgData")as! Data)
////            let str = ((savedata?.value(forKey: "img")as! NSDictionary).value(forKey: "name")as! String)
//
//            print(String(describing: url as! String))

         }

}


