//
//  MainViewController.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2020/12/23.
//

import UIKit


//Preview와 StoryBoard는 서로 연결 할 수가 없다. ㅋㅋㅋ
class MainViewController: UIViewController {

    let mainCollectionView : UICollectionView = {
       
        let flowLayOut = UICollectionViewFlowLayout()
        flowLayOut.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayOut)
        collectionView.backgroundColor = .lightGray
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()
    
    let dataControl = coreDataControl.shared
    var messages : [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "Message"
        // Do any additional setup after loading the view.
        setCollectionView()
        setCollectionViewLayout()
        dataControl.saveSomeMessage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        messages = dataControl.getAllMessages()
    }

}

extension MainViewController {
    private func setCollectionViewLayout(){
        
        mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: BaseCell.cellName)
        
        view.addSubview(mainCollectionView)
        
        NSLayoutConstraint.activate([
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension MainViewController : UICollectionViewDelegate , UICollectionViewDataSource  {
    
    private func setCollectionView(){
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let messages = messages else {return UICollectionViewCell()}
        
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: BaseCell.cellName, for: indexPath) as! MainCollectionViewCell
        
        
        cell.message = messages[indexPath.row]
//        cell.backgroundColor = .red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nextVC = ChatViewController()
        nextVC.friend = messages![indexPath.item].chat_friend
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    
}

extension MainViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: mainCollectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

import SwiftUI

struct MainPreView : PreviewProvider {
    
    static var previews: some View {
//        Text("Hello world").padding()
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView : UIViewControllerRepresentable{
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return MainViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        
        
    }
    
}
