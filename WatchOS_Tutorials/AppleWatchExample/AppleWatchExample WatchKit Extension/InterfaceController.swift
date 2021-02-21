//
//  InterfaceController.swift
//  AppleWatchExample WatchKit Extension
//
//  Created by yoon tae soo on 2021/02/21.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var labelFinishedTime : WKInterfaceLabel!
    @IBOutlet weak var labelTaksName : WKInterfaceLabel!
    
    @IBOutlet weak var buttonRewid : WKInterfaceButton!
    @IBOutlet weak var buttonPlay : WKInterfaceButton!
    @IBOutlet weak var buttonForward : WKInterfaceButton!
    @IBOutlet var sliderVolume : WKInterfaceSlider!
    
    
    var interface : TableInterfaceController?
    
    @IBAction func buttonRewindTap() {
        
        print("press Rewind")
        
    }
    
    @IBAction func buttonPlayTap() {
        
        print("press Play")
    }
    
    @IBAction func buttonForwardTap() {
        
        print("press Forward")
    }
    
    @IBAction func sliderAction(_ value: Float) {
        
        print("value : \(value)")
    }
    
    @IBAction func deleteTap(){
        
        let okAction = WKAlertAction(title: "Delete", style: .destructive) {
            print("Delete")
            
            let selectRow = self.interface?.selectedRow ?? 0
            
            self.interface?.tasks.remove(at: selectRow)
        
            DispatchQueue.main.async {
                self.pop()
            }
            
        }
        
        let cancelAction = WKAlertAction(title: "Cancel", style: .default) {
            self.dismiss()
        }
        
        presentAlert(withTitle: "Warning", message: "Are you sure you wnat to delete this?", preferredStyle: .alert, actions: [okAction , cancelAction])
        
    }
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        
        guard let interface = context as? TableInterfaceController else {return}
        
        self.interface = interface
        
        let item = interface.tasks[interface.selectedRow ?? 0]
        
        print("items : \(item)")
        
        labelFinishedTime.setText(item.finishedTime)
        labelFinishedTime.setTextColor(item.color)
        
        labelTaksName.setText(item.taskName)
        labelTaksName.setTextColor(item.color)
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
