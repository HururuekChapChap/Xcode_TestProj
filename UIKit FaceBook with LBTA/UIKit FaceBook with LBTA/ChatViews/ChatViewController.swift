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
        
        if let messageText = messages?[indexPath.item].detail{
            
            //그릴 공간
            let maxSize = CGSize(width: 250, height: 1000)
            
            //높이를 기준으로 하겠다.
            let heightOnFont = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 20)], context: nil)
            
            print(maxSize.width , estimatedFrame.width, estimatedFrame.height)
            cell.bubbleView.frame = CGRect(x: 40 + 12, y: 0, width: estimatedFrame.width + 20, height: estimatedFrame.height + 16)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
}

extension ChatViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messages?[indexPath.item].detail{
            //이 공간 안에 최대로 넣어진다면 그 공간에 맞게 그려주게 된다.
            let maxSize = CGSize(width: 250, height: 1000)
            let heightOnFont = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 20)], context: nil)
            
            return CGSize(width: chatcollectionView.frame.width, height: estimatedFrame.height + 16)
        }
        
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
