//
//  ViewController.swift
//  MVC_Test
//
//  Created by yoon tae soo on 2020/10/02.
//

import UIKit

class ViewController: UIViewController {

    var myView : View?
    var tistroy : Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tistroy = Info.init("Hururuek", "12")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubView")
        myView = View(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        myView!.center = view.center
        myView!.changeLabel(tistroy!.makeText())
        view.addSubview(myView!)
    }
    
    @IBAction func changeBTN(_ sender: UIButton) {
        tistroy!.changeInfo("ChapChap", "67")
        myView!.changeLabel(tistroy!.makeText())
    }
    
}

struct Info {
    
    var name : String
    var id : String
    
    init(_ name : String, _ id : String){
        self.name = name
        self.id = id
    }
    
    mutating func changeInfo(_ name : String, _ id : String){
        self.name = name
        self.id = id
    }
    
    func makeText() -> String{
        return "\(name) : \(id)"
    }
}

