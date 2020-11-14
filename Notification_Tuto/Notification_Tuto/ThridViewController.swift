//
//  ThridViewController.swift
//  Notification_Tuto
//
//  Created by yoon tae soo on 2020/11/14.
//

import UIKit

class ThridViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var label: UILabel!
    
    private let Month : [String] = ["1","2","3","4","5","6","7", ]
    
    private let Day : [String] = ["1","12","31","4","25","6","17"]
    
    var inputFormate : DateFormatter {
        get{
            let formate = DateFormatter()
            formate.dateFormat = "MM dd"
            return formate
        }
    }
    
    var outputFormate : DateFormatter{
        get{
            let formate = DateFormatter()
            formate.dateFormat = "MM월 dd일"
            return formate
        }
    }
    
    private var date : String{
        get{
         
            let firstIndex = pickerView.selectedRow(inComponent: 0)
            let secondeIndex = pickerView.selectedRow(inComponent: 1)
            
            return "\(Month[firstIndex]) \(Day[secondeIndex])"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ThridViewController Load")
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    @IBAction func notificationBtn(_ sender: UIButton) {
        
        print("pressed")
        
        //send object - object and values - userInfo
        NotificationCenter.default.post(name: .dateNotification, object: self, userInfo: ["date":date])
        
    }
    
}

extension ThridViewController : UIPickerViewDelegate{
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            return Month[row]
        default:
            return Day[row]
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            print(Month[row])
        default:
            print(Day[row])
        }
        
    }
    
}

extension ThridViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return Month.count
        default:
            return Day.count
        }
        
    }
    
}



/*
 
 let formate = DateFormatter()
 formate.dateFormat = "MM-dd"
 let item = formate.date(from: "1-2")
 
 print(item)
 
 formate.dateFormat = "MM , dd"
 let newDate = formate.string(from:item!)
 print(newDate)
 
 String => Date => String
 
 문자열로 구성된 날짜를 원하는 방식으로 다시 변환 하기 위해서는
 DateFormatter를 이용해야한다.
 DateFormatter . dateFormat를 원하는 형식으로 만들어줘야한다.
 yyyy : 년도
 MM : 월 0 - 12 까지 모두 허용
 dd : 일 0 - 31 까지 모두 허용
 
 그리고 이것을 formate.date(string)를 사용해서 Date 형식으로 만들어 준다.
 하지만 이때 string은 우리가 앞에 설정한 형식이랑 동일해야한다.
 그리고 마지막에 formate.string(date)가 들어가면 된다.
 
 */
