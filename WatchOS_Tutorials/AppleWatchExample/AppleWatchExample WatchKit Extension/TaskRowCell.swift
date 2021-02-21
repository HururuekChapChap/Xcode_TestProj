//
//  TaskRowCell.swift
//  AppleWatchExample WatchKit Extension
//
//  Created by yoon tae soo on 2021/02/21.
//

import WatchKit

class TaskRowCell: NSObject {
    @IBOutlet weak var labelTaskName : WKInterfaceLabel!
    @IBOutlet weak var labelFinishedTime : WKInterfaceLabel!
    @IBOutlet weak var imageViewTask : WKInterfaceImage!
    
    var task : Task?{
        
        didSet{
            labelTaskName.setText(task?.taskName)
            labelTaskName.setTextColor(task?.color)
            
            labelFinishedTime.setText(task?.finishedTime)
            labelFinishedTime.setTextColor(task?.color)
            
            imageViewTask.setImageNamed(task?.iconName)
            imageViewTask.setTintColor(task?.color)
        }
        
    }
}
