//
//  ShareViewController.swift
//  shareEx101
//
//  Created by yoon tae soo on 2020/12/20.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    
    
    //post 버튼이 false 라면 꺼져 있음 반대로 true 라면 켜져 있음
    //이 부분은 TextField에 들어가는 부분
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        
        //플레이스 홀더
        self.placeholder = "Hello world"
        
        //contentText는 shareExtension의 TextField 부분
        return self.contentText.isEmpty ? false : true
    }
    
    //Cancel을 선택 했을 때 나오는 것
    override func didSelectCancel() {
        print("Cancel Click")
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        
        let item = SLComposeSheetConfigurationItem()!
        item.title = "Hello"
        item.value = "ChapChap"
        item.tapHandler = {
            let vc = ShareExViewController()
            self.pushConfigurationViewController(vc)
        }
        
        return [item]
    }

}
