//
//  SecondViewController.swift
//  push_notification
//
//  Created by yoon tae soo on 2020/11/22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let notification = NotificationCenter.shared
    let notifications = ["Local Notification","Snooze Notification", "Delete Notification"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableViewDelegate()
        // Do any additional setup after loading the view.
    }
    
}

extension SecondViewController : UITableViewDelegate , UITableViewDataSource {
    
    func setTableViewDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Cell else {
            return UITableViewCell()
        }
        
        cell.updateUI(input: notifications[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let notificationType = notifications[indexPath.row]
        
        let alert = UIAlertController(title: "",
                                message: "After 5 seconds " +
                                notificationType + " will appear", preferredStyle: .alert)
               
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.notification.CategoryNotification(input: notificationType)
               }
               
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }

}


class Cell : UITableViewCell {
    
    @IBOutlet weak var label : UILabel!
    
    func updateUI(input  : String) {
        label.text = input
    }
    
}
