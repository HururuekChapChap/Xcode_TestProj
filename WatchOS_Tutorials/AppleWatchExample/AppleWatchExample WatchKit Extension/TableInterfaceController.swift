//
//  TableInterfaceController.swift
//  AppleWatchExample WatchKit Extension
//
//  Created by yoon tae soo on 2021/02/21.
//

import WatchKit
import Foundation
import WatchConnectivity

extension UIColor{
    
    convenience init(r : CGFloat , g : CGFloat , b : CGFloat) {
        self.init(red : r/255.0 , green : g/255.0 , blue : b/255.0 , alpha : 1)
    }
    
}


class TableInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table : WKInterfaceTable!
    
    var watchSession : WCSession?
    
    var tasks : [Task] = [
        
        Task(taskName: "Play", finishedTime: "07:00", iconName: "play", color: UIColor(r: 237, g: 135, b: 63)),
        Task(taskName: "Pause", finishedTime: "08:00", iconName: "pause", color: UIColor(r: 238, g: 250, b: 108)),
        Task(taskName: "fast-forward", finishedTime: "09:00", iconName: "fast-forward", color: UIColor(r: 130, g: 248, b: 180)),
        Task(taskName: "rewind", finishedTime: "10:00", iconName: "rewind-button", color: UIColor(r: 212, g: 55, b: 106))
        
    
    ]
    
    var selectedRow : Int?
    
    private func configureTable(){
        
        table.setNumberOfRows(tasks.count, withRowType: "table")
        
        for (index , item) in tasks.enumerated(){
            
            guard let row = table.rowController(at: index) as? TaskRowCell else {continue}
            
            row.task = item
            
        }
        
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        

        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        configureTable()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print("rowIndex : \(rowIndex)")
        //Navigation으로 만드는 방법
        selectedRow = rowIndex
        pushController(withName: "InterfaceController", context: self)
        
        //presentController은 여러가지가 있는데 이렇게 하나의 페이지로 이동하는 방법도 있다.
//        presentController(withName: <#T##String#>, context: <#T##Any?#>)
        //만약에 이렇게 present로 화면 전환을 했으면 dismiss() 함수로 이전으로 돌아 갈 수 있다.
    }

}

extension TableInterfaceController : WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session activatoin did complete")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("watch recevied app context : ", applicationContext)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("received data : \(message)")
        
        session.sendMessage(message, replyHandler: nil, errorHandler: nil)
        
    }
    


}
