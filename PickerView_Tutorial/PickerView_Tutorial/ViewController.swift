//
//  ViewController.swift
//  PickerView_Tutorial
//
//  Created by yoon tae soo on 2020/11/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var horiPickerView: UIPickerView!
    
    var dataModelPicker : DataModelPickerView!
    var dataModelHoriPicker : DataModelPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        settingPickerView()
        settingHoriPickerView()
        
    }
    
    func settingPickerView(){
        
        dataModelPicker = DataModelPickerView(frame: .zero)
        
        //pickerView의 기능을 dataModelPicker가 대신하겠다!
        pickerView.delegate = dataModelPicker
        pickerView.dataSource = dataModelPicker
        
        
    }
    
    func settingHoriPickerView(){
        
        let horiY = horiPickerView.frame.origin.y
        
        horiPickerView.frame = CGRect(x: 0, y: horiY, width: 100, height: 200)
        
//        horiPickerView.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180))
        
        dataModelHoriPicker = DataModelPickerView(frame: .zero)
        
        horiPickerView.delegate = dataModelHoriPicker
        horiPickerView.dataSource = dataModelHoriPicker
        
    }


}

