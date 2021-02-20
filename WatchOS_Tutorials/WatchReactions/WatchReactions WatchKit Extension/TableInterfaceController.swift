//
//  TableInterfaceController.swift
//  WatchReactions WatchKit Extension
//
//  Created by yoon tae soo on 2021/02/20.
//

import WatchKit
import Foundation
import AVFoundation

class TableInterfaceController: WKInterfaceController , SoudPlaying_PR{
    
    var audioPlayer: AVAudioPlayer?
    

    @IBOutlet weak var table: WKInterfaceTable!
    
    //Returns an array of file URLs for all resources identified by the specified file extension and located in the specified bundle subdirectory.
    //[URL] 배열로 반환이 되는데, mp3로 되어 있는 모든 url들을 가져오게 된다.
    let soundURList = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil)
    var sortedResult : [String] = []
    //viewDidLoad
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
//        print(" result of soundURList => \n \(soundURList)")
        
        //deletingPathExtension은 잘못된 형식의 URL을 삭제시켜주는 것 같다. -- 추측
        let result1 = soundURList?.map({$0.deletingPathExtension()}) ?? []
        
//        print(" result of result1 => \n \(result1)")
        
        //Dock -- url 이렇게 되어 있는데, 마지막에 -- url 부분을 제거해준다. 그리고 URL 타입에서 String으로 변경 시켜준다.
        let result2 = result1.map({$0.lastPathComponent})
        
        //결과를 보면 모두 String인 것을 알 수 있다.
        print(" result of result2 => \n \(result2)")
        
        sortedResult = result2.sorted()
        
        table.setNumberOfRows(sortedResult.count, withRowType: "Row") // withRowType은 우리가 Interface에서 tableController의 이름을 뜻 한다.
        
        for (index , item) in result2.enumerated() {
            
            //table의 row를 생성한 후에 index에 해당하는 row를 가져오게 된다.
            guard let row = table.rowController(at: index) as? SoundRow else {continue}
            
            //row의 타입이 SoundRow NSObject로 되어 있기 때문에
            row.textLabel.setText(item)
            
            //
            
        }
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        playSound(namee: sortedResult[rowIndex])
    }

}
