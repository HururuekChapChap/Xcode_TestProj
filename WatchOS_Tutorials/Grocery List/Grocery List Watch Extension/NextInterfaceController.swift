//
//  NextInterfaceController.swift
//  Grocery List Watch Extension
//
//  Created by yoon tae soo on 2021/02/20.
//

import WatchKit
import Foundation


class NextInterfaceController: WKInterfaceController {

    @IBOutlet var myLabel : WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func buttonTapped(){
        
        //음성이나 손가락으로 글씨를 쓰는 행위 또는 이모티콘을 적는 행위에 대한 Apple의 기술
        //withSuggestions는 특정한 글 들이 적혀 있도록 해서
        //쉽게 글을 쓸 수 있도록 하는 것
        //allowedInputMode에서 plain으로 하면 음성과 손가락으로 글쓰기만 생기고 이모티콘에 대한 것은 없어진다.
        self.presentTextInputController(withSuggestions: ["Sound"], allowedInputMode: .plain) { (result) in
            //결과물이 나옴
            //예를들어 음성으로 말했다면, 그 부분이 배열로 결과를 반환
            guard let results = result else {return}
            
//            OperationQueue.main.addOperation {
//                //실행에 대한 결과를 멈추게 하고
//                self.dismissTextInputController()
//                //라벨에 보여주기로 함
//                self.myLabel.setText(results[0] as? String)
//            }
            
            DispatchQueue.main.async {
                //실행에 대한 결과를 멈추게 하고
                self.dismissTextInputController()
                //라벨에 보여주기로 함
                self.myLabel.setText(results[0] as? String)
            }
        }
        
    }

}
