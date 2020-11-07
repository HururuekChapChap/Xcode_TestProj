//
//  ViewController.swift
//  DispatchGroup_Tuto
//
//  Created by yoon tae soo on 2020/11/07.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items : [String] = []
    
    let inputDatas : [[String]] = [["1 : Swift", "Xcode"], ["2: JAVA", "Eclips"], ["3: C++", "Visual Studio"]]
    
    let times : [Int] = [2,5,3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setDelegate()
    }

    @IBAction func downLoadBtn(_ sender: UIButton) {
        
//        fetchItemsWithNormal()
        fetchItmesWithGroup()
    }
    
}

//ETC Function
extension ViewController {
    
    func run(time : Int , completeHandler : @escaping () -> ()){
        
        let dispatchTime : DispatchTime = .now() + .seconds(time)
        
        DispatchQueue.global().asyncAfter(deadline: dispatchTime) {
            completeHandler()
        }
    
    }
    
    //이러한 방식은 많은 자원을 소요하게 되고
    //순서대로 나오지 않게 된다....
    func fetchItemsWithNormal(){
    
        for (index ,input) in inputDatas.enumerated() {
            
            run(time: times[index]) {
                self.items.append(contentsOf: input)
                
                print("Complete fetch Data \(index) : \(self.times[index])")
                
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
            }
            
        }
        
    }
    
    func fetchItmesWithGroup(){
        
        let dispatchGroup = DispatchGroup()
        
        for (index ,input) in inputDatas.enumerated() {
            
            dispatchGroup.enter()
            run(time: times[index]) {
                self.items.append(contentsOf: input)
                print("Complete fetch Data \(index) : \(self.times[index])")
                dispatchGroup.leave()
            }
            
        }
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
        
        
    }
    
    
}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    //위임을 받도록 한다.
    func setDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell else {return UITableViewCell()}
        
        cell.updateLabel(text: items[indexPath.row])
        
        return cell
    }
    
}


class TableViewCell : UITableViewCell {
    
    @IBOutlet weak var label : UILabel!
    
    override func prepareForReuse() {
        label.text = nil
    }
    
    func updateLabel(text : String){
        label.text = text
    }
    
}

