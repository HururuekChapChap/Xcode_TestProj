//
//  MainCollectionViewCell.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2020/12/23.
//

import UIKit


class BaseCell : UICollectionViewCell {
    
    static let cellName : String = "MainCollectionViewCell"
    static let chatName : String = "ChatCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        backgroundColor = .red
    }
    
}

class MainCollectionViewCell: BaseCell {
    
    lazy var imageView : UIImageView = {
       
        let image = UIImage(named: "sorry.png")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = self.frame.height / 4
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        return imageView
        
    }()
    
    let dividLineView : UIView = {
       let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabel : UILabel = {
        let label = UILabel()
        label.text = "My name is Hururuek ChapChap, Nice to meet you guys"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "12:45"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var message : Message? {
        didSet{
            nameLabel.text = message!.chat_friend?.name
            messageLabel.text = message!.detail
            timeLabel.text = changeDateFormat(date: message!.date!)
        }
    }

    override func setupView() {
        backgroundColor = .white
        imageViewLayout()
        setupdividLineView()
        setupContainerView()
        setupNameLabel()
        setupMessageLabel()
        setupTimeLabel()
    }
    
    private func changeDateFormat(date : Date) -> String{
        let dateformat = DateFormatter()
        dateformat.dateFormat = "hh:mm"
        
        return dateformat.string(from: date)
    }
    
}

extension MainCollectionViewCell {
    
    private func imageViewLayout(){
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        
    }
    
    private func setupdividLineView(){
        addSubview(dividLineView)
        
        NSLayoutConstraint.activate([
            
            dividLineView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            dividLineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dividLineView.heightAnchor.constraint(equalToConstant: 2)
        
        ])
    }
    
    private func setupContainerView(){
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }
    
    private func setupNameLabel(){
        containerView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupMessageLabel(){
        containerView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 5)
        ])
        
    }
    
    private func setupTimeLabel(){
        
        containerView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            timeLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
        
        
    }
}
