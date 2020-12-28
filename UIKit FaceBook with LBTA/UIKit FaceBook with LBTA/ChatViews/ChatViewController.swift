//
//  ChatViewController.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2020/12/28.
//

import UIKit

class ChatViewController: UIViewController {
    
    var messages : [Message]?
    
    var friend : Friend?{
        didSet{
            
            let temp = friend?.chat_message?.allObjects as? [Message]
            
            messages = temp?.sorted(by: { (mess1, mess2) -> Bool in
                return mess1.date! < mess2.date!
            })
        }
    }
    
    let chatcollectionView : UICollectionView = {
       
        let flowlayOut = UICollectionViewFlowLayout()
        flowlayOut.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayOut)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        setDelegate()
        collectionViewAuto()
        // Do any additional setup after loading the view.
        
        if let friendName = friend?.name{
            navigationItem.title = friendName
        }
    }


}


extension ChatViewController {
        
    private func collectionViewAuto(){
        view.addSubview(chatcollectionView)
        
        NSLayoutConstraint.activate([
            chatcollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            chatcollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatcollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatcollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setRegister()
    }
    
    private func setRegister(){
        chatcollectionView.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: BaseCell.chatName)
    }
}

extension ChatViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    private func setDelegate(){
        chatcollectionView.delegate = self
        chatcollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = chatcollectionView.dequeueReusableCell(withReuseIdentifier: BaseCell.chatName, for: indexPath) as? ChatCollectionViewCell else {return UICollectionViewCell()}
        
        
        cell.textView.text = messages![indexPath.item].detail
        
        return cell
    }
    
}

extension ChatViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: chatcollectionView.frame.width, height: 200)
    }
    
}


import SwiftUI

struct ChatPreView : PreviewProvider {
    
    static var previews: some View {
//        Text("Hello world").padding()
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView : UIViewControllerRepresentable{
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return ChatViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        
    }
    
}
