//
//  ViewController.swift
//  AutolayOut_Code
//
//  Created by yoon tae soo on 2020/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    var pageControl : UIPageControl = {
       
        let pagecontrol = UIPageControl()
        pagecontrol.currentPage = 0
        pagecontrol.numberOfPages = 4
        pagecontrol.currentPageIndicatorTintColor = .systemRed
        pagecontrol.pageIndicatorTintColor = .systemGray
        pagecontrol.backgroundStyle = .minimal
        pagecontrol.allowsContinuousInteraction = false
        
        return pagecontrol
    }()
    
    //  Intro Auto Layout - 3
    var mainstackView : UIStackView = {
    
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    //  Intro Auto Layout - 3
    let nextBtn : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
//        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //  Intro Auto Layout - 3
    let previousBtn : UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.systemPink, for: .normal)
//        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    //  Intro Auto Layout - 2
    let containerView : UIView = {
        
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //  Intro Auto Layout - 2
    let textView_2 : UITextView = {
        
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let attributeText = NSMutableAttributedString(string: "Hello world \n let's build that app", attributes: [.font : UIFont.boldSystemFont(ofSize: 24)])
        
        let sideText = NSAttributedString(string: "\n\n\n\nI need to learn how to make autolayout with code. By doing so. I will make lots of IOS app on my hand", attributes: [.font : UIFont.systemFont(ofSize: 17) , .foregroundColor: UIColor.darkGray])
        
        attributeText.append(sideText)
        
        textView.attributedText = attributeText
        
        textView.textAlignment = .center
//        textView.isScrollEnabled = false
        textView.isEditable = false
        
        return textView
    }()
    
    //################ NOT USED #######################
    
    //  Intro Auto Layout - 1
    let smartPhone_imageView : UIImageView  = {
        
        let image = UIImage(named: "smartphone.png")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    //  Intro Auto Layout - 1
    let textView : UITextView = {
        let textView = UITextView()
        textView.text = "Hello world"
        textView.textAlignment = .center
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    //################ NOT USED #######################
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        smartPhone_AutoLayout()
//        textView_AutoLayout()
        
        containerView_AutoLayout()
        smartPhone_AutoLayout_2()
//        textView_AutoLayout_2()
        
//        buttonAutoLayout()
        stackViewAutoLayout()
        textView_AutoLayout_3()
    }

    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        pageControl.subviews.forEach { (view) in
//            view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//        }
//
//    }


}


//  Intro Auto Layout - 3
extension ViewController {
    
    func stackViewAutoLayout(){
    
        //항상 먼저 넣어줘야하는거 잊지 말아야한다.
        view.addSubview(mainstackView)
            
        let yellowview = UIView()
        yellowview.backgroundColor = .yellow
        mainstackView.addArrangedSubview(previousBtn)
        mainstackView.addArrangedSubview(pageControl)
        mainstackView.addArrangedSubview(nextBtn)

        
        NSLayoutConstraint.activate([
            mainstackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainstackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainstackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainstackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12)
        ])
        
    }
    
    func buttonAutoLayout(){
        
        view.addSubview(previousBtn)
        
        NSLayoutConstraint.activate([
            previousBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            previousBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            previousBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            previousBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12)
        ])
        
    }
    
    func textView_AutoLayout_3(){
        view.addSubview(textView_2)
        
        textView_2.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        textView_2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        textView_2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        textView_2.bottomAnchor.constraint(equalTo: mainstackView.topAnchor).isActive = true
    }
    
    
}

//  Intro Auto Layout - 2
extension ViewController {
    //  Intro Auto Layout - 2
    func containerView_AutoLayout(){
        
        view.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    //  Intro Auto Layout - 2
    func smartPhone_AutoLayout_2(){
        
        containerView.addSubview(smartPhone_imageView)
        
        smartPhone_imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        smartPhone_imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        smartPhone_imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.6).isActive = true
        smartPhone_imageView.widthAnchor.constraint(equalTo: smartPhone_imageView.heightAnchor, multiplier: 1).isActive = true
        
    }
    
    func textView_AutoLayout_2(){
        view.addSubview(textView_2)
        
        textView_2.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        textView_2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        textView_2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        textView_2.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// Intro Auto Layout - 1
extension ViewController {

    // Intro Auto Layout - 1
    func smartPhone_AutoLayout(){
        
        view.addSubview(smartPhone_imageView)
        
        smartPhone_imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        smartPhone_imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        smartPhone_imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        smartPhone_imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    // Intro Auto Layout - 1
    func textView_AutoLayout(){
        
        view.addSubview(textView)
        
        textView.topAnchor.constraint(equalTo: smartPhone_imageView.bottomAnchor, constant: 50).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
}

