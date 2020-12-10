//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift

class MenuViewController: UIViewController {
    // MARK: - Life Cycle

    let menuViewModel = MenuViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemCountLabel.text = "\(menuViewModel.itemCount)"
//        totalPrice.text = "\(menuViewModel.totalPrice.currencyKR())"
        
        //scan은 reduce와 같은 것이다. 초기값을 주고 계속 값을 변경 가능하다.
        menuViewModel.totalPrice
            .scan(0, accumulator: { (seed, plusItem) -> Int in
                return seed + plusItem
            })
            .map { (item) -> String in
            return "\(item.currencyKR())"
        }.subscribe { (event) in
            
            switch event {
            case .next(let result) :
                self.totalPrice.text = result
            case .error(_):
                break
            case .completed:
                break
            }
        }.disposed(by: disposeBag)
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
            let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
    }

    @IBAction func onOrder(_ sender: UIButton) {
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
        // performSegue(withIdentifier: "OrderViewController", sender: nil)
        
        menuViewModel.totalPrice.onNext(100)
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuViewModel.menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell") as! MenuItemTableViewCell

        let menu = menuViewModel.menus
        
        cell.title.text = menu[indexPath.row].name
        cell.price.text = "\(menu[indexPath.row].price)"
        cell.count.text = "\(menu[indexPath.row].count)"

        return cell
    }
}
