//
//  ViewController.swift
//  Paste_N_Post_Tuto
//
//  Created by yoon tae soo on 2020/09/14.
//  Copyright © 2020 yoon tae soo. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var ImageView: UIImageView!
    let pasteBoard = UIPasteboard.general
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        // Do any additional setup after loading the view.
    }

    @IBAction func CopyText(_ sender: Any) {
        pasteBoard.string = textField.text
        textField.text = ""
    }
    
    @IBAction func PasteText(_ sender: Any) {
        
        if pasteBoard.hasStrings{
            
            let temp = pasteBoard.string!
            if temp.starts(with: "https://") {
                
                DispatchQueue.global().async {
                    if let tempImage = self.updateImage(temp) {
                    
                    DispatchQueue.main.async {
                        self.ImageView.image = tempImage
                    }
                        
                    }
                }
                
            }
            else{
            
            textField.text = pasteBoard.string
                
            }
        }
        else if pasteBoard.hasImages{
            ImageView.image = pasteBoard.image
        }
        
    }
    
}

extension ViewController : UITextViewDelegate {
    
    func updateImage(_ url : String) -> UIImage?{
        
        let url = URL(string: url)!
        
        guard let imageData = try? Data(contentsOf: url) else {return nil}
        
        return UIImage(data: imageData)
    }
    
    func setDelegate(){
        textField.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
    
}

