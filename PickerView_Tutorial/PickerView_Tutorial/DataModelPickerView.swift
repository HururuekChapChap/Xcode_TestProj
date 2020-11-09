//
//  DataModelPickerView.swift
//  PickerView_Tutorial
//
//  Created by yoon tae soo on 2020/11/09.
//

import UIKit

struct DataModel {
    
    let dayName : String
    let price : String
    let date : String
    
}

struct Data {
        
   static func getData() -> [DataModel] {
    
        var data : [DataModel] = []
        
        data.append(DataModel(dayName: "월", price: "10000", date: "20 11 09"))
        data.append(DataModel(dayName: "화", price: "20000", date: "20 11 10"))
        data.append(DataModel(dayName: "수", price: "30000", date: "20 11 11"))
        data.append(DataModel(dayName: "목", price: "40000", date: "20 11 12"))
        data.append(DataModel(dayName: "금", price: "50000", date: "20 11 13"))
        data.append(DataModel(dayName: "토", price: "60000", date: "20 11 14"))
        data.append(DataModel(dayName: "일", price: "70000", date: "20 11 15"))
        
        return data
    }
    
    
}


class DataModelPickerView: UIPickerView {

    var dataModels : [DataModel] = []
    
    let height : CGFloat = 150
    
//    convenience init() {
//        self.init(frame: CGRect.zero)
//              //assign custom vars
//        dataModels = Data.getData()
//    }
    
    override init(frame: CGRect) {
               super.init(frame: frame)
        dataModels = Data.getData()
          }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        dataModels = Data.getData()
//    }

}

extension DataModelPickerView : UIPickerViewDelegate {
    
    //하나의 글만 보여 줄 때는 이러한 방법을 사용한다.
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return dataModels[row].dayName
//    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return height
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: height))
        
        let stackview = UIStackView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: height))
        stackview.distribution = .fillEqually
        stackview.axis = .vertical
        stackview.spacing = 2
        
        let topLabel = UILabel()
        topLabel.text = dataModels[row].dayName
        topLabel.textColor = .black
        topLabel.textAlignment = .center
        topLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        stackview.addArrangedSubview(topLabel)
        
        let midLabel = UILabel()
        midLabel.text = dataModels[row].price
        midLabel.textColor = .orange
        midLabel.textAlignment = .center
        midLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)

        stackview.addArrangedSubview(midLabel)

        let endLable = UILabel()
        endLable.text = dataModels[row].date
        endLable.textColor = .red
        endLable.textAlignment = .center
        endLable.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        stackview.addArrangedSubview(endLable)
        
        view.addSubview(stackview)
        
        return view
    }
    
}

extension DataModelPickerView : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataModels.count
    }

}

