//
//  ShareViewController.swift
//  ShareEx102
//
//  Created by yoon tae soo on 2020/12/20.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let extensionItems = extensionContext?.inputItems as! [NSExtensionItem]
        
        for items in extensionItems{
            if let itemProviders = items.attachments {
             
                for item_provider in itemProviders {
                    
                    if item_provider.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
                        
                        item_provider.loadItem(forTypeIdentifier: kUTTypeImage as String, options: nil) { (data, error) in
                            print("Image : \(data)")
                        }
                        
                
                        
                    }
                    
                    
                    if item_provider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                        
                        item_provider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) { (data, error) in
                            
//                            var urlData: Data!
//                            let dict: [String : Any] = ["url" :  data!]
                            
//                            if let url = data as? URL{
//                                urlData = try! Data(contentsOf: url)
//                            }
//
                            
                            
                            
                            let savedata =  UserDefaults.init(suiteName: "group.TeamProj.ShareExtension102.ShareEx102")
                            
                            if let url = data as? URL{
                            
//                            let test = String(describing: url)
//
//                            print("URL : \(test)")
//
//                            savedata?.set(test, forKey: "urlData")
//                            savedata?.synchronize()
//
//                            let sendCom = String(describing:  savedata?.value(forKey: "urlData") )
//
//                            print("urlData : \(sendCom)")
                                
                                var arrayList : [String] = []
                                
                                if let allData = savedata?.object(forKey: "urlData"){
                                    
                                    if let tempList = allData as? NSArray{
                                        arrayList = tempList as! [String]
                                    }
                                    
                                }
                                
                                let test = url.absoluteString
                                
                                arrayList.append(test)
                               
                                print(arrayList)
                                
                                savedata?.setValue(arrayList, forKey: "urlData")
                                savedata?.synchronize()
                                
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }

}
