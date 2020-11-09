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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let horiY = horiPickerView.frame.origin.y
        let horiHeight = horiPickerView.frame.height

        horiPickerView.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180))
        horiPickerView.frame = CGRect(x: 0, y: horiY, width: view.frame.width, height: horiHeight)
        horiPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        horiPickerView.topAnchor.constraint(equalTo: pickerView.bottomAnchor
                    ,constant: 30).isActive = true
    }
    
    func settingPickerView(){
        
        dataModelPicker = DataModelPickerView(frame: .zero)
        
        //pickerView의 기능을 dataModelPicker가 대신하겠다!
        pickerView.delegate = dataModelPicker
        pickerView.dataSource = dataModelPicker
        
        
    }
    
    func settingHoriPickerView(){
        
        dataModelHoriPicker = DataModelPickerView(frame: .zero)
        
        horiPickerView.delegate = dataModelHoriPicker
        horiPickerView.dataSource = dataModelHoriPicker
        
    }


}

