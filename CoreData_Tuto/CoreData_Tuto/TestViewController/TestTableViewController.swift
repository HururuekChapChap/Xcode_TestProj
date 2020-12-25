//
//  TableViewController.swift
//  CoreData_Tuto
//
//  Created by yoon tae soo on 2020/12/25.
//

import UIKit

struct cellIdenties {
    
    static let mainCell = "mainCell"
    
}

class TestTableViewController: UIViewController {
    
    let mainTableView : UITableView = {
       
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
        
    }()
    
   lazy var naviButton : UIButton = {
       
        let button = UIButton()
        button.setTitle("Hello", for: .normal)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.setTitleColor(.cyan, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        navigationItem.title = "tableView"
        // Do any additional setup after loading the view.
        
        setDelegate()
        configureTableView()
        navigationItem()
        
    }
    
    private func navigationItem(){
        
        guard let navigationbar = navigationController?.navigationBar else {return}
        
        navigationbar.addSubview(naviButton)
        
//        naviButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        NSLayoutConstraint.activate([
            
            naviButton.trailingAnchor.constraint(equalTo: navigationbar.trailingAnchor),
            naviButton.bottomAnchor.constraint(equalTo: navigationbar.bottomAnchor),
          
        
        ])
        
    }
    
    @objc func click(){
        print("Hello world")
    }
    
    
    private func configureTableView(){
        
        registureCell()
        view.addSubview(mainTableView)
        
        NSLayoutConstraint.activate([
        
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        
    }
    
    private func registureCell(){
        
        mainTableView.register(mainCell.self, forCellReuseIdentifier: cellIdenties.mainCell)
        
    }
    
}

extension TestTableViewController : UITableViewDelegate , UITableViewDataSource{
    
    private func setDelegate(){
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: cellIdenties.mainCell) as! mainCell
        
        return cell
    }
    
    
}

class TableCell : UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){}
    
}

class mainCell : TableCell {
    
    let nameLabel : UILabel = {
       
        let label = UILabel()
        label.text = "Hello world"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    let Button : UIButton = {
       
        let button = UIButton(type: .system)
        button.setTitle("Hello", for: .normal)
//        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.setTitleColor(.cyan, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func configureUI() {
//        setUpNameLabel()
        setUpButton()
    }
    
    private func setUpNameLabel(){
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
    
    }
    
    
    private func setUpButton(){
        
        //Cell 위에다가 올리면 ContentView 밑에 넣기 때문에 안됀다,,,
        //Cell의 contentView 위에 Button을 올려야 한다.
        //그냥 대부분의 Cell을 사용하면 Content View 위에 올려는게 맞는 듯
        contentView.addSubview(Button)
        
        //그리고 Button의 addTarget은 init Closure 안에 넣어서 실행 시키면 안됀댜.
        //그래서 이렇게 밖으로 빼야한다.
        Button.addTarget(self, action: #selector(testclick), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            Button.topAnchor.constraint(equalTo: contentView.topAnchor),
            Button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            Button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            Button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
        ])
        
    }
    
    
    @objc func testclick(){
        print("Hello Cell")
    }
    
}
