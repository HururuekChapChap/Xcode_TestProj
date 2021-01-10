//
//  ChatViewController.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2020/12/28.
//

import UIKit
import CoreData

class ChatViewController: UIViewController , NSFetchedResultsControllerDelegate{

//    var messages : [Message]?
    
    var friend : Friend?{
        didSet{
            //fetchResultController 내부에 자체적으로 정렬 기능이 있기 때문에 사용할 필요가 없다.
//            let temp = friend?.chat_message?.allObjects as? [Message]
//            messages = temp?.sorted(by: { (mess1, mess2) -> Bool in
//                return mess1.date! < mess2.date!
//            })
        }
    }
    
    let cdControl = coreDataControl.shared
    
    lazy var fetchResultController : NSFetchedResultsController<Message> = {
       
        let fetchRequest : NSFetchRequest<Message> = Message.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: true)
        let filter = NSPredicate(format: "chat_friend.name = %@", self.friend!.name!)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = filter
        let fetchResult = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: cdControl.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResult.delegate = self
        return fetchResult
    }()
    
    var blockOperations : [BlockOperation] = []
    
    // NSFetchedResultsControllerDelegate를 처리한 후에
    // 이 didChange anObject 함수를 호출하면 CoreData가 변화 할 때 마다 호출 된다.
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            //BlockOperation은 비동기적인 작업이기 때문에 이렇게 넣어주고
            blockOperations.append(BlockOperation(block: {
                self.chatcollectionView.insertItems(at: [newIndexPath!])
            }))
            
            print(newIndexPath!)
//            chatcollectionView.insertItems(at: [newIndexPath!])
//            chatcollectionView.scrollToItem(at: newIndexPath!, at: .bottom, animated: true)
        }
    }
    
    //CoreData에 변화가 감지 됐을 때, 작동하는 것
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        //CollectionView에 여러가지 작업을 수행 할 때 사용
        chatcollectionView.performBatchUpdates {
            //각 작업을 수행 해준다.
            for item in blockOperations {
                item.start()
            }
            
        } completion: { (_) in
            
            let lastItem = self.fetchResultController.sections![0].numberOfObjects - 1
            let indexpath = IndexPath(item: lastItem, section: 0)
            self.chatcollectionView.scrollToItem(at: indexpath, at: .bottom, animated: true)
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
        view.backgroundColor = .lightText
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inputTextField : UITextField = {
       
        let textField = UITextField()
        textField.placeholder = "Enter Here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var sendButton : UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(selectBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    var bottomLayoutConstrain : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try fetchResultController.performFetch()
            print("fetchResultController section count : ",fetchResultController.sections?.count)
            print("fetchResultController section[0] count : ",fetchResultController.sections?[0].numberOfObjects)
            
            // Message에 해당하는 모든 값을 다 가져옴 따라서 NSPredicate로 filtering을 해줘야한다. (NSPredicate를 안해줬을 때)
        }
        catch let err{
            print(err)
        }
        
        //탭바 숨기기
        tabBarController?.tabBar.isHidden = true
        
        //navigation right button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simulate", style: .plain, target: self, action: #selector(simuateBtn))
        
        view.backgroundColor = .yellow
        setDelegate()
        setContainerView()
        collectionViewAuto()
        setButton()
        setTextField()
        // Do any additional setup after loading the view.
        addKeyBoardNotification()
        if let friendName = friend?.name{
            navigationItem.title = friendName
        }
    }
    
    @objc private func simuateBtn(){
        
        cdControl.createMessage(friend: friend!, pluse: 0, detail: "Hello World")
        cdControl.createMessage(friend: friend!, pluse: 0, detail: "I'm Sorry haha")
        
        /* //fetchResultConroller의 Delegate에 insert에서 처리해줄 예정
         let tempMess = cdControl.createMessage(friend: friend!, pluse: 0, detail: "Hello World")
        messages?.append(tempMess)
        
        let itemLocation = messages!.count - 1
        let insertionIndexPath = IndexPath(item: itemLocation, section: 0)
        
        //특정한 라인에 아이템 넣는 방법
        chatcollectionView.insertItems(at: [insertionIndexPath])
        self.chatcollectionView.scrollToItem(at: insertionIndexPath, at: .bottom, animated: true)
        */
    }
    
    @objc private func selectBtn(){
        guard let text = inputTextField.text  else {return}
        
        print(text)
        
        cdControl.createMessage(friend: friend!, pluse: 0, detail: text, isSender: true)
        /*
        //fetchResultConroller의 Delegate의 insert에서 처리해줄 예정
         let tempMess = cdControl.createMessage(friend: friend!, pluse: 0, detail: text, isSender: true)
        messages?.append(tempMess)
        
        let itemLocation = messages!.count - 1
        let insertionIndexPath = IndexPath(item: itemLocation, section: 0)
        
        //특정한 라인에 아이템 넣는 방법
        chatcollectionView.insertItems(at: [insertionIndexPath])
        self.chatcollectionView.scrollToItem(at: insertionIndexPath, at: .bottom, animated: true)
        */
        inputTextField.text = ""
    }
    
    private func addKeyBoardNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc private func keyBoardWillHide(_ noti : Notification){
        
        bottomLayoutConstrain?.isActive = false
        
        self.bottomLayoutConstrain = messageInputContainerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        
        UIView.animate(withDuration: 0) {
            
            self.bottomLayoutConstrain?.isActive = true
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc private func keyBoardWillShow(_ noti : Notification){
        guard let userInfo = noti.userInfo else {return}
        
        if let keyBoardFrame : NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            print( "cgRectVale : " ,keyBoardFrame.cgRectValue)
            print("widht : " ,keyBoardFrame.cgRectValue.width)
            print("height : " ,keyBoardFrame.cgRectValue.height)
                        
            bottomLayoutConstrain?.isActive = false
            
            UIView.animate(withDuration: 0) {
                self.bottomLayoutConstrain = self.messageInputContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyBoardFrame.cgRectValue.height)
                
                self.bottomLayoutConstrain?.isActive = true
                
                self.view.layoutIfNeeded()
            } completion: { _ in
                
                let lastItem = self.fetchResultController.sections![0].numberOfObjects - 1
                let indexpath = IndexPath(item: lastItem, section: 0)
                
                self.chatcollectionView.scrollToItem(at: indexpath, at: .bottom, animated: true)
                
                //!@@@@@@@//
//                let indexPathItem = IndexPath(item: self.messages!.count - 1, section: 0)
//                self.chatcollectionView.scrollToItem(at: indexPathItem, at: .bottom, animated: true)
            }

            
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
//            chatcollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            chatcollectionView.bottomAnchor.constraint(equalTo: messageInputContainerView.topAnchor)
        ])
        
        setRegister()
    }
    
    private func setRegister(){
        chatcollectionView.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: BaseCell.chatName)
    }
    
    private func setContainerView(){
        view.addSubview(messageInputContainerView)
        
        bottomLayoutConstrain = messageInputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            messageInputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputContainerView.heightAnchor.constraint(equalToConstant: 48),
            bottomLayoutConstrain!
        ])
    }
    
    private func setTextField(){
        messageInputContainerView.addSubview(inputTextField)
    
        NSLayoutConstraint.activate([
            inputTextField.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor, constant: 10),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            inputTextField.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor),
            inputTextField.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor)
        ])
        
    }
    
    private func setButton(){
        
        messageInputContainerView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor),
            sendButton.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor, constant: -10),
            sendButton.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
}

extension ChatViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    private func setDelegate(){
        chatcollectionView.delegate = self
        chatcollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return fetchResultController.sections?[0].numberOfObjects ?? 0
        //fetchResultController를 사용하면 더이상 message 배열을 사용할 필요가 없다.
//        return messages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = chatcollectionView.dequeueReusableCell(withReuseIdentifier: BaseCell.chatName, for: indexPath) as? ChatCollectionViewCell else {return UICollectionViewCell()}
        
        
        //FectchResultController를 사용해서 더욱 간결하게 코드를 작성 했다.
        let temp_message = fetchResultController.object(at: indexPath)
//        print(temp_message.detail, temp_message.isSender , indexPath.item)
        guard let messageText = temp_message.detail else {return UICollectionViewCell()}
        
        cell.textView.text = messageText
        
//        cell.textView.text = messages![indexPath.item].detail
        
//        if let temp_message = messages?[indexPath.item] , let messageText = temp_message.detail{
        
            
            //그릴 공간
            let maxSize = CGSize(width: 255, height: 1000)
            
            //높이를 기준으로 하겠다.
            let heightOnFont = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 20)], context: nil)
            
//            print(maxSize.width , estimatedFrame.width, estimatedFrame.height)
            
            // 상대방이 보낸것일 때
            if !temp_message.isSender {
                
//                @@@ if 문을 하지 않으면 내가 보내는 것으로 나옴. @@@
                if cell.bubbleView.backgroundColor == UIColor.red {
                    cell.bubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
                    cell.textView.textColor = .black
                    cell.imageView.isHidden = false
                }
                
                cell.bubbleView.frame = CGRect(x: 40 + 12, y: 0, width: estimatedFrame.width + 25, height: estimatedFrame.height + 16)
            }
            // 내가 보내는 것일 때
            else{
                print(temp_message.detail, temp_message.isSender , indexPath.item)
                cell.bubbleView.frame = CGRect(x: chatcollectionView.frame.width - estimatedFrame.width - 23, y: 0, width: estimatedFrame.width + 20, height: estimatedFrame.height + 16)
                
                cell.bubbleView.backgroundColor = .red
                cell.textView.textColor = .white
                cell.imageView.isHidden = true
                
            }
            
//        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
    
}

extension ChatViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let temp_message = fetchResultController.object(at: indexPath)
        
//        if let messageText = messages?[indexPath.item].detail{
        if let messageText = temp_message.detail{
            //이 공간 안에 최대로 넣어진다면 그 공간에 맞게 그려주게 된다.
            let maxSize = CGSize(width: 255, height: 1000)
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
