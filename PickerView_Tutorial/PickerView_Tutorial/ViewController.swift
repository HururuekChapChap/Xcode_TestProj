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
    
    var token : NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
      token = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: Notification.Name.pickerNoti), object: nil, queue: .main) { (data) in
            print("Nofi on")
        }
        
        settingPickerView()
        settingHoriPickerView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let token = token {
            
            NotificationCenter.default.removeObserver(token)

        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        //왜 Frame을 여기에다가 해주면 오류가 발생하는지 알았다.
//        viewDidLayoutSubviews() 에서는 계속해서 Update Cycle 마다 생성하기 때문에 frame을 매번 변경해주는 것이다
        //그런데 frame = CGRect를 이미 오토레이아웃이 정해진 곳에서 사용하려면 viewdidLoad에서는 사용이 안된다.
        //왜냐하면 viewDidLoad에서는 view를 구성하지 않기 때문이다.
        //따라서 viewDidLayoutSubView에서 해줘야하는데 그러면 Picker View를 사용 할 때 마다 frame을 재구성하게 되서
        //오류가 발생한다. 벽돌현상이 되어 버린다.
    }
    
    
    func settingPickerView(){
        
        dataModelPicker = DataModelPickerView(frame: .zero)
        
        //pickerView의 기능을 dataModelPicker가 대신하겠다!
        pickerView.delegate = dataModelPicker
        pickerView.dataSource = dataModelPicker
        
        
    }
    
    func settingHoriPickerView(){
       
        let horiHeight = horiPickerView.frame.height
        let horiWidth = horiPickerView.frame.width
        
        dataModelHoriPicker = DataModelPickerView(frame: .zero)
        dataModelHoriPicker.type = true
        //let horiY = horiPickerView.frame.origin.y
       

        print(horiHeight / horiWidth)
        print(view.bounds.width / horiWidth)

        //X가 높이가 되고 Y가 가로 길이가 된다.
        horiPickerView.transform = CGAffineTransform(rotationAngle: -90 * (.pi / 180)).scaledBy(x: horiHeight / horiWidth, y: view.bounds.width / horiHeight)

        
        horiPickerView.delegate = dataModelHoriPicker
        horiPickerView.dataSource = dataModelHoriPicker
        
    }


}

