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
    
    let messageInputContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inputTextField : UITextField = {
       
        let textField = UITextField()
        textField.placeholder = "Enter Here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //탭바 숨기기
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .yellow
        setDelegate()
        collectionViewAuto()
        setContainerView()
        setTextField()
        // Do any additional setup after loading the view.
        addKeyBoardNotification()
        if let friendName = friend?.name{
            navigationItem.title = friendName
        }
    }
    
    private func addKeyBoardNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    @objc private func keyBoardWillShow(_ noti : Notification){
        guard let userInfo = noti.userInfo else {return}
        
        if let keyBoardFrame : NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            print( "cgRectVale : " ,keyBoardFrame.cgRectValue)
            
            print("widht : " ,keyBoardFrame.cgRectValue.width)
            print("height : " ,keyBoardFrame.cgRectValue.height)
            
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
    
    private func setContainerView(){
        view.addSubview(messageInputContainerView)
        
        NSLayoutConstraint.activate([
            messageInputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputContainerView.heightAnchor.constraint(equalToConstant: 48),
            messageInputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setTextField(){
        messageInputContainerView.addSubview(inputTextField)
        
        NSLayoutConstraint.activate([
            inputTextField.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor, constant: 10),
            inputTextField.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor),
            inputTextField.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor),
            inputTextField.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor)
        ])
        
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
        
        if let temp_message = messages?[indexPath.item] , let messageText = temp_message.detail{
            
            //그릴 공간
            let maxSize = CGSize(width: 250, height: 1000)
            
            //높이를 기준으로 하겠다.
            let heightOnFont = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 20)], context: nil)
            
//            print(maxSize.width , estimatedFrame.width, estimatedFrame.height)
            
            if !temp_message.isSender {
                
                cell.bubbleView.frame = CGRect(x: 40 + 12, y: 0, width: estimatedFrame.width + 20, height: estimatedFrame.height + 16)
            }
            else{
            
                cell.bubbleView.frame = CGRect(x: chatcollectionView.frame.width - estimatedFrame.width - 23, y: 0, width: estimatedFrame.width + 20, height: estimatedFrame.height + 16)
                
                cell.bubbleView.backgroundColor = .systemBlue
                cell.textView.textColor = .white
                cell.imageView.isHidden = true
                
            }
            
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
