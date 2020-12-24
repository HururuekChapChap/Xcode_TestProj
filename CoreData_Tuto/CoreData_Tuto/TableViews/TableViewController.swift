//
//  TableViewController.swift
//  CoreData_Tuto
//
//  Created by yoon tae soo on 2020/12/24.
//

import UIKit

class TableViewController: UIViewController {
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let textField : UITextView = {
       
        let textfield = UITextView()
        textfield.backgroundColor = .brown
        textfield.text = "Hello world"
        textfield.isScrollEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        configureScrollView()
        configureStackView()
        

        configureTextField()
 
        let kittenImageView1 = UIImageView(image: UIImage(named: "Icon"))
        kittenImageView1.translatesAutoresizingMaskIntoConstraints = false
//        kittenImageView1.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        kittenImageView1.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.stackView.addArrangedSubview(kittenImageView1)
        // Do any additional setup after loading the view.
    }
    
    private func configureScrollView(){
        view.addSubview(scrollView)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    private func configureStackView(){
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureTextField(){
        stackView.addArrangedSubview(textField)
        
    }


}





