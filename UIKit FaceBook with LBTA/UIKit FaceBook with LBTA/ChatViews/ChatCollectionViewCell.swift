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
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
        
    }()
    
    //오토레이아웃 적용 ㄴㄴ
    let bubbleView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let imageView : UIImageView = {
       
        let imageView = UIImageView(image: UIImage(named: "sorry.png"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func setupView() {
        
        backgroundColor = .lightGray
        setUPtextView()
        setUpImageView()
    }
    
    private func setUPtextView(){
        
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: bubbleView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor)
        ])
        
    }
    
    private func setUpImageView(){
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        
        ])
        
    }
    
}
