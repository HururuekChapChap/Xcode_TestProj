//
//  SwipeViewController.swift
//  AutolayOut_Code
//
//  Created by yoon tae soo on 2020/12/22.
//

import UIKit

class SwipeViewController: UIViewController {
    
    let pageItems : [pageModel] = [
    
        pageModel(imageName: "smartphone.png", titleLabel: "Hello world \n let's build that app", bodyLabel: "I need to learn how to make autolayout with code. By doing so. I will make lots of IOS app on my hand"),
        pageModel(imageName: "browser.png", titleLabel: "Did I doint well??", bodyLabel: "I don't know that I doing right thing,,,,"),
        pageModel(imageName: "sorry.png", titleLabel: "Can I get the job???", bodyLabel: "I don't know someone Help me")
    
    ]

    let swipecollectionView : UICollectionView = {
        
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let flowLayOut = UICollectionViewFlowLayout()
        flowLayOut.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame : frame, collectionViewLayout: flowLayOut)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
       
        return collectionView
    }()
    
    let cellID = "CustomCell"
    
    lazy var pageControl : UIPageControl = {
       
        let pagecontrol = UIPageControl()
        pagecontrol.currentPage = 0
        pagecontrol.numberOfPages = pageItems.count
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
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        stackViewAutoLayout()
        setUpCollectionView()
        setUpCellResgister()
    }
    
    @objc private func handlePrev(){
        
        let nextPage = max(pageControl.currentPage - 1 , 0)
        let indexPath = IndexPath(item: nextPage, section: 0)
        pageControl.currentPage = nextPage
        swipecollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    @objc private func handleNext(){
        
        let nextPage = min(pageControl.currentPage + 1 , pageItems.count - 1)
        let indexPath = IndexPath(item: nextPage, section: 0)
        pageControl.currentPage = nextPage
        swipecollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    func setUpCollectionView(){
        
        view.addSubview(swipecollectionView)
        
        swipecollectionView.delegate = self
        swipecollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            swipecollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            swipecollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swipecollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            swipecollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            swipecollectionView.bottomAnchor.constraint(equalTo: mainstackView.topAnchor)
        ])
        
    }
    
    func stackViewAutoLayout(){
    
        //항상 먼저 넣어줘야하는거 잊지 말아야한다.
        view.addSubview(mainstackView)
     
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
    
    //Custom Cell 등록
    func setUpCellResgister(){
        
        swipecollectionView.register(customCell.self, forCellWithReuseIdentifier: cellID)
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let targetOffset = targetContentOffset.pointee.x
        
        let currentPage = Int(targetOffset / view.frame.width)
        
        pageControl.currentPage = currentPage
        
//        print(targetOffset , view.frame.width , scrollView.contentSize.width)
        
    }
    

}

extension SwipeViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = swipecollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? customCell else {return UICollectionViewCell()}
        
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .white : .red
        
        cell.pageItem = pageItems[indexPath.item]
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate { (_) in
            self.swipecollectionView.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.swipecollectionView.contentOffset = .zero
            }
            else{
                
                let currentIndex = self.pageControl.currentPage
                let indexPath = IndexPath(item: currentIndex, section: 0)
                self.swipecollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
            }
            
        } completion: { (_) in}

        
//        swipecollectionView.reloadData()
        }
    
    
}

extension SwipeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
        return CGSize(width: self.swipecollectionView.frame.width, height: self.swipecollectionView.frame.height)
    }
    
    //Cell의 Section 사이의 거리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        //top : Cell과 Cell 사이의 top 거리
        //left : Cell과 View left 사이의 거리
        //right : Cell과 view right 사이의 거리
        //bottom : Cell의 Bottom 거리
//        return UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //Cell과 Cell 사이의 가운데 거리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 60
        return 0
    }
    
}

class customCell : UICollectionViewCell {
    
    var pageItem : pageModel? {
        didSet{
            
            updateUI()
            
        }
    }
    
    
    let imageName : UIImageView = {
       
        let image = UIImage(named: "smartphone.png")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    let containerView : UIView = {
        
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView_AutoLayout()
        imageName_AutoLayout_2()
        textView_AutoLayout_2()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension customCell {
    
    func updateUI(){
        
        guard let pageItem = pageItem else {return}
        
        imageName.image = UIImage(named: pageItem.imageName)
        
        let attributeText = NSMutableAttributedString()
        
        let titleAttributes = NSAttributedString(string: pageItem.titleLabel, attributes: [.font : UIFont.boldSystemFont(ofSize: 24)])
        let bodyAttributes = NSAttributedString(string: "\n\n\n\n\(pageItem.bodyLabel)", attributes: [.font : UIFont.systemFont(ofSize: 17) , .foregroundColor: UIColor.darkGray])
        
        attributeText.append(titleAttributes)
        attributeText.append(bodyAttributes)
        
        textView_2.attributedText = attributeText
        textView_2.textAlignment = .center
    }
    
    //  Intro Auto Layout - 2
    func containerView_AutoLayout(){
        
        addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    //  Intro Auto Layout - 2
    func imageName_AutoLayout_2(){
        
        containerView.addSubview(imageName)
        
        imageName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageName.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        imageName.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.6).isActive = true
        imageName.widthAnchor.constraint(equalTo: imageName.heightAnchor, multiplier: 1).isActive = true
        
    }
    
    func textView_AutoLayout_2(){
        addSubview(textView_2)
        
        textView_2.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        textView_2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        textView_2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        textView_2.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
}
