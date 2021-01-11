//
//  MainViewController.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2020/12/23.
//

import UIKit
import CoreData

protocol SendUpdateProtocol : class {
    func sendUpdated()
}


//Preview와 StoryBoard는 서로 연결 할 수가 없다. ㅋㅋㅋ
class MainViewController: UIViewController , NSFetchedResultsControllerDelegate, SendUpdateProtocol{
    
    func sendUpdated() {
        click()
    }
    
    let dataControl = coreDataControl.shared
    
    let mainCollectionView : UICollectionView = {
       
        let flowLayOut = UICollectionViewFlowLayout()
        flowLayOut.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayOut)
        collectionView.backgroundColor = .lightGray
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()
    
    lazy var fetchResultController : NSFetchedResultsController<Friend> = {

        let fetchRequest : NSFetchRequest<Friend> = Friend.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastMessgae.date", ascending: false)]
        let fetchResult = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataControl.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResult.delegate = self
        return fetchResult
    }()

    var messages : [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //데이터를 performFetch() 이전에 가져와야 한다.
        dataControl.saveSomeMessage()
        
        do{

            try fetchResultController.performFetch()
            print("fetch finish")

        }catch let err{
            print("Freind Fetch Error" , err.localizedDescription)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .plain, target: self, action: #selector(click))
        self.navigationItem.title = "Message"
        // Do any additional setup after loading the view.
        setCollectionView()
        setCollectionViewLayout()
        
        let cnt = fetchResultController.sections?[0].numberOfObjects
        if let item = fetchResultController.sections?[0].objects as? [Friend] {
            print(cnt! , item[0].name!)
        }
        else{
            print("Not type")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        messages = dataControl.getAllMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        <#code#>
//    }
    
    @objc private func click(){
//        mainCollectionView.reloadData()
        
        do {
            try fetchResultController.performFetch()
            
            mainCollectionView.reloadData()
        }
        catch let err{
            print(err.localizedDescription)
        }
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
        
        return fetchResultController.sections?[0].numberOfObjects ?? 0
        
//        return messages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let test = fetchResultController.object(at: indexPath)
        
//        guard let messages = messages else {return UICollectionViewCell()}
        
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: BaseCell.cellName, for: indexPath) as! MainCollectionViewCell
        
//        print(test.lastMessage)
        
        cell.message = test.lastMessgae
        
//        cell.message = messages[indexPath.row]
//        cell.backgroundColor = .red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let test = fetchResultController.object(at: indexPath)
        
        let nextVC = ChatViewController()
//        nextVC.friend = messages![indexPath.item].chat_friend
        nextVC.friend = test
        
        //너의 일을 내가 대신 해줄게
        nextVC.delegate = self
        
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
