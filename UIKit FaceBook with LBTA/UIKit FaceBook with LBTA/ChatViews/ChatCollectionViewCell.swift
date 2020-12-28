//
//  ChatCollectionViewCell.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2020/12/28.
//

import UIKit

class ChatCollectionViewCell: BaseCell {
    
    let textView : UITextView = {
       
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.text = "Sample Text"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
        
    }()
    
    override func setupView() {
        
        
        setUPtextView()
        
    }
    
    private func setUPtextView(){
        
        contentView.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
}
