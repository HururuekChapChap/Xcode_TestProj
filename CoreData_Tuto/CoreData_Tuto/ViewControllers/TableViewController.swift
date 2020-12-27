//
//  TableViewController.swift
//  CoreData_Tuto
//
//  Created by yoon tae soo on 2020/12/25.
//

import UIKit

class TableViewController: UIViewController {

    let maintableView : UITableView = {
       
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    lazy var plusButton : UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 50)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(plusBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var buttonTrailing : NSLayoutConstraint!
    var buttonBottom : NSLayoutConstraint!
    
    //reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items : [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TableView"
        view.backgroundColor = .white
        configureTableView()
        setTableViewDeleate()
        configureNavibtn()
        fetchItems()
    }
    
    @objc private func plusBtn(){
        
        let alert = UIAlertController(title: "Add Person", message: "What is there name?", preferredStyle: .alert)
        
        alert.addTextField { (textfeld) in
            textfeld.placeholder = "Insert name"
        }
        
        let submitButton = UIAlertAction(title: "Add", style: .default, handler: { (action) in
            
            let textField = alert.textFields![0]
            
            //Create a new Person Object -> context가 추적한다.
            let newPerson = Person(context: self.context)
            newPerson.name = textField.text
            newPerson.age = "25"
            newPerson.birth = Date()
            
            //Save the Data
            do{
                try self.context.save()
                
            }
            catch(let error){
                print( "Save Data Error :\(error.localizedDescription)")
            }
            
            self.fetchItems()
            
        })
        
        alert.addAction(submitButton)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func fetchItems(){
        
        do{
            let temp = try context.fetch(Person.fetchRequest())
            items = temp as? [Person]
            
            DispatchQueue.main.async {
                self.maintableView.reloadData()
            }
        }
        catch (let error){
            print( "fetch Data Error :\(error.localizedDescription)")
        }
        
    }


}

//layOut extension
extension TableViewController {
 
    private func configureTableView(){
        
        view.addSubview(maintableView)
            
        NSLayoutConstraint.activate([
            maintableView.topAnchor.constraint(equalTo: view.topAnchor),
            maintableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            maintableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            maintableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        maintableView.register(dataViewCell.self, forCellReuseIdentifier: TableViewCell.dataViewCell)
        
    }
    
    private func configureNavibtn(){
        
        guard let navigationBar = navigationController?.navigationBar else {return}
        
        navigationBar.addSubview(plusButton)
        
        buttonTrailing = plusButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -10)
        buttonBottom = plusButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        
        NSLayoutConstraint.activate([
            buttonTrailing,
            buttonBottom,
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func changeButtonSize(height : CGFloat){
        
        let ratio = CGFloat((height / 91))
        
//        print(height, ratio, plusButton.frame.width)
        
        if ratio > 1.5 {return}
        
        plusButton.transform = CGAffineTransform.identity.scaledBy(x: ratio, y: ratio)
        
        self.buttonBottom.isActive = false
        
        UIView.animate(withDuration: 0) {
            
            if height <= 44 {
                self.buttonBottom = self.plusButton.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)! , constant: 1)
            }
            else{
                self.buttonBottom = self.plusButton.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!)
                
            }
        
            self.buttonBottom.isActive = true
            
            self.plusButton.layoutIfNeeded()
        }
        
        
    }
    
}

extension TableViewController :  UITableViewDelegate , UITableViewDataSource {
    
    private func setTableViewDeleate(){
        
        maintableView.delegate = self
        maintableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let items = items else {return UITableViewCell()}
        
        let cell = maintableView.dequeueReusableCell(withIdentifier: TableViewCell.dataViewCell) as! dataViewCell
        
        let item = items[indexPath.row]
        
        cell.cellLabel.text = item.name
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navigationHeight = navigationController?.navigationBar.frame.height else {return}
        
        changeButtonSize(height: navigationHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let personItem = self.items![indexPath.row]
        
        let alert = UIAlertController(title: "Edit Person", message: "Edit Name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = personItem.name
        }
        
        let saveButton = UIAlertAction(title: "Save", style: .default, handler: {_ in
            
            let textField = alert.textFields![0]
            
//            personItem.name = textField.text
            
            let newTodo = Todo(context: self.context)
            newTodo.name = textField.text
            
            
            personItem.addToTodoList([newTodo])
            
            do{
                try self.context.save()
            }
            catch (let error){
                print( "Update Data Error :\(error.localizedDescription)")
                self.context.rollback()
            }
            
            self.fetchItems()
            
        })
        
        alert.addAction(saveButton)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "내부 1번 삭제") { (_, _, _) in
            
            let personToRemove = self.items![indexPath.row]
            
            if let item = personToRemove.todoList?.allObjects as? [Todo] , !item.isEmpty{
            
                self.context.delete(item[0])
                
                do{
                    try self.context.save()
                }
                catch (let error){
                    print( "Delete Data Error :\(error.localizedDescription)")
                }
                    
                
                
                self.fetchItems()
            }
            
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { (action, view, nil) in
                
            let personToRemove = self.items![indexPath.row]
            
            self.context.delete(personToRemove)
            
            do{
                try self.context.save()
            }
            catch (let error){
                print( "Delete Data Error :\(error.localizedDescription)")
            }
            
            self.fetchItems()
            
            
        }
        
        delete.backgroundColor = .systemRed
        
        let showList = UIContextualAction(style : .normal, title : "내용출력"){ (_,_,_) in
            
            let personInfo = self.items![indexPath.row]
            
            if let list = personInfo.todoList?.allObjects as? [Todo] , !list.isEmpty{
                
                print("Not empty")
                
                for item in list{
                    print(item.name!)
                }
                
                
            }
            else{
                print("It's empty")
            }
            
        }
        
        showList.backgroundColor = .systemBlue
        
        let actionConfigure = UISwipeActionsConfiguration(actions: [delete, showList])
        actionConfigure.performsFirstActionWithFullSwipe = false
        
        return actionConfigure
        
        
    }
    
}
