//
//  InterfaceController.swift
//  WatchReactions WatchKit Extension
//
//  Created by yoon tae soo on 2021/02/18.
//

import WatchKit
import Foundation
import AVFoundation

class InterfaceController: WKInterfaceController , SoudPlaying_PR {
     
    var audioPlayer: AVAudioPlayer?
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    
    //appleWatch에는 tag가 없기 때문에 확실한 구분을
    //할수가 없다. 따라서 이렇게 함수명에 정확히 기입하는 것을 추천한다.
    @IBAction func playSound1() {
        playSound(namee: "Song")
    }
    
    @IBAction func playSound2() {
        playSound(namee: "Dock")
    }
    
    @IBAction func playSound3() {
        playSound(namee: "Lot_To_Learn")
    }
    
    @IBAction func playSound4() {
        
        playSound(namee: "Faraway")
        
    }
}
