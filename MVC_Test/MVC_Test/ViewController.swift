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
    var flag : Bool = true
    
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
        
        if flag {
        
        myView = View(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        myView!.center = view.center
        myView!.changeLabel(tistroy!.makeText())
        view.addSubview(myView!) //subview를 해줘야 layoutsubView가 발동한다.
//            myView!.removeFromSuperview()
            //removeFromSuperView를 하면 layoutSubView 호출이 되지 않는다.
            //그래서 추측으로는 코드가 다 되고 나서 update Cycle이라는 것이 있는데, 그 순간에 되는거 같다.
            //즉 viewDidLayoutSubView 와 ViewDidAppear 사이에 update Cycle이라는 것이 있는 것 같다.
        
            flag = false
        }
        else{
            myView!.removeFromSuperview()
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
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

