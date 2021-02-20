//
//  CustomInterfaceController.swift
//  WatchReactions WatchKit Extension
//
//  Created by yoon tae soo on 2021/02/20.
//

import WatchKit
import Foundation
import AVFoundation

class CustomInterfaceController: WKInterfaceController {

    //저장할 링크를 가져오고 recording.wav 파일 이라는 이름으로 저장 할 것이다.
    let saveURL = FileManager.default.getDocumentsDirectory().appendingPathComponent("recording.wav")
    var audioPlayer : AVAudioPlayer?
    
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

    @IBAction func recodeTapped() {
        
        //기본적으로 워치에서 녹음 기능을 제공한다.
        //그런데, 이 코드만 적어서 되는 것이 아니라, App의 info.plist에 Privacy - Microphone Usage Description
        //을 추가 해줘야한다.
        presentAudioRecorderController(withOutputURL: saveURL, preset: .narrowBandSpeech, options: nil) { (success, err) in
            
            if success{
                //save 버튼을 누르고 나면 이렇게 아래 메시지가 나온다.
                print("save successfully!")
            }
            else{
                print(err?.localizedDescription ?? "Unkown error")
            }
            
        }
        
    }
    
    @IBAction func playTapped() {
        
        //이렇게 파일을 불러 올 수 있다.
        guard FileManager.default.fileExists(atPath: saveURL.path) else {return}
        
        try? audioPlayer = AVAudioPlayer(contentsOf: saveURL)
        
        audioPlayer?.play()
        
    }
    
}
