//
//  ProtocolFile.swift
//  WatchReactions WatchKit Extension
//
//  Created by yoon tae soo on 2021/02/20.
//

import Foundation
import AVFoundation

protocol SoudPlaying_PR : class{
    
    var audioPlayer : AVAudioPlayer? {get set}
    

}

extension SoudPlaying_PR {
    
    func playSound(namee name : String){
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            fatalError("Unable to find sound file \(name).mp3")
        }
        
        do{
        
            audioPlayer = try? AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }
            
    }
    
}
