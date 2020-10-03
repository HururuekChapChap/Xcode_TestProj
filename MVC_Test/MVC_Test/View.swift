//
//  View.swift
//  MVC_Test
//
//  Created by yoon tae soo on 2020/10/02.
//

import UIKit

class View: UIView {
    
    var label : UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeLabel(_ text : String){
        print(text)
        label.text = text
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews")
        label.sizeToFit()
        label.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        
    }

}
