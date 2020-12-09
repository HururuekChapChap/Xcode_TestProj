//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class 나중에생기는데이터<T>{
    private let task : (@escaping (T) -> Void) -> Void
    
    init(task : @escaping (@escaping (T) -> Void) -> Void) {
        self.task = task
    }
    
    func 나중에오면(_ later : @escaping (T) -> Void) {
        task(later)
    }
}

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }
    
    
    //이러한 방식으로 하면 된다,,,
    //하지만 사람들은 이렇게 complete 방식이 아닌 그냥 return 방식으로 해결하고 싶다는 궁리를 했다.
    //그래서 RxSwift의 용도는 비동기적으로 생기는 데이터를 return 값으로 전달하기 위해서 탄생했다.
    func downloadJson(_ url : String , complete : ((String?) -> Void)?){
        
        DispatchQueue.global().async {
            
            let url = URL(string: url)!
            let data = try! Data(contentsOf: url)
            let json = String(data: data, encoding: .utf8)
            DispatchQueue.main.async {
                
                // 반환되는 것이 nil 값일 때는 escaping이 default 이다.
                complete?(json)
            }
        }
        
    }
    
    func downloadJson(_ url : String) -> 나중에생기는데이터<String?>{
        
        
        return 나중에생기는데이터 { (task) in
            DispatchQueue.global().async {
                
                let url = URL(string: url)!
                let data = try! Data(contentsOf: url)
                let json = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    
                    task(json)
                }
            }
        }
       
        
    }
    
    //create()로 Observable 객체를 생성한다.
    //그리고 위에서 task() 부분을 onNext가 하게 되고,, 즉 데이터를 실제로 실행하는 부분
    //그리고 onCompleted()에서는 모든 과정이 끝마지면 자동적으로 종료되도록 한다.
    //마지막에 create()의 반환은 Disposable이라는 것 잊지않는다.
    
    func downloadJsonForTest(_ url : String) -> Observable<String>{
        //(RxSwift.AnyObserver<Self.Element>) -> RxSwift.Disposable) -> RxSwift.Observable<Self.Element>
        return Observable.create() { emitter in
            
            emitter.onNext("Hello World")
            emitter.onNext("ChapChap")
            // 모든 작업을 마쳤습니다.
            emitter.onCompleted()
            return Disposables.create()
            
        }
        
    }
    
    //just는 오직하나의 데이터만 전달한다.
    func downloadJsonWithJust(_ url : String) -> Observable<String> {
        
        return Observable.just("Hello World")
        
    }
    
    //따라서 이렇게 다수의 데이터를 보낼 때도 [] 형식으로 보내지게 된다.
    func downloadJsonWithJustArray(_ url : String) -> Observable<[String]> {
        
        return Observable.just(["Hello World", "ChapChap"])
        
    }
    
    //그럼 여러개의 데이터를 보내기 위해서는 어떻게 해야하나,,,
    //바로 이렇게 from을 사용해주면 된다.
    //그럼 결과가 Hello World \n ChapChap
    //나온다
    func downloadJsonWithFrom(_ url : String) -> Observable<String>{
        return Observable.from(["Hello World", "ChapChap"])
    }
    
//    RxSwift 생명주기
//    Create
//    Subscribe
//    onNext
//    -----------끝----------
//    onCompleted / onError
//    Disposed

    
    func downloadJson(_ url : String) -> Observable<String>{
        
        return Observable.create { emitter in
            
            let url = URL(string: url)!
            
          let task =  URLSession.shared.dataTask(with: url) { (data, _, err) in
                
                if let err = err {
                    print("Error")
                    emitter.onError(err)
                    return
                }
                
                guard let dta = data , let json = String(data: dta, encoding: .utf8) else {
                    print("Has error in data")
                    return
                }
                emitter.onNext(json)
                emitter.onCompleted()
                
            }
            
            task.resume()
            
            return Disposables.create()
        }
    }
    
    // MARK: SYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)

        
//        downloadJson(MEMBER_LIST_URL) { (json) in
//            self.editView.text = json!
//            self.setVisibleWithAnimation(self.activityIndicator, false)
//        }
//
//
//        let json : 나중에생기는데이터<String?> = downloadJson(MEMBER_LIST_URL)
//
//        json.나중에오면 { (json) in
//            self.editView.text = json!
//            self.setVisibleWithAnimation(self.activityIndicator, false)
//        }
        
//        var result : Observable<String> = downloadJsonForTest(MEMBER_LIST_URL)
        
//        result = downloadJsonWithJust(MEMBER_LIST_URL)
        
//        let test : Observable<[String]> = downloadJsonWithJustArray(MEMBER_LIST_URL)
        
//        result = downloadJsonWithFrom(MEMBER_LIST_URL)
            

        let result : Observable<String> = downloadJson(MEMBER_LIST_URL)

//        let disposable = result.subscribe({ event in
//
//            switch event {
//
//            case .next(let result):
////                print(result)
//                DispatchQueue.main.async {
//                    self.editView.text = result
//                    self.setVisibleWithAnimation(self.activityIndicator, false)
//                }
//
//            case .error(_):
//                print("Got Error")
//                break
//            case .completed:
//                print("Yes Completed")
//                break
//            }
//
//        })
        
        //sugur라고 불린다 이런 API를
        result.observeOn(MainScheduler.instance) // operator라고 부른다. MainThread에서 작동시킨다
            .subscribe(onNext: {json in
                self.editView.text = json
                self.setVisibleWithAnimation(self.activityIndicator, false)
            })
        
        
        result.map { (json) -> Int in
            return json.count
        }
        .filter { (result) -> Bool in
            return result > 0
        }
        // 맨위의 작업을 정해준다. 따라서 맨 처음 map은 background에서 작업을 하게 되고
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
        .map({ (result) -> String in
            return String(result)
        })
        //이 부분 부터 MainThread에서 작동한다.
        .observeOn(MainScheduler.instance)
        .subscribe { (event) in
            
            switch event {
            
            case .next(let json):
                self.editView.text = json
                self.setVisibleWithAnimation(self.activityIndicator, false)
            case .error(_):
                break
            case .completed:
                break
            }
        }
        
            
        

        //Subscrible의 작업이 모두 마치고 나면 종료 시킨다. 따라서 작업이 종료 되기 전에 이 코드를 쓰면
        //작업 수행이 되지 않는다.
//        disposable.dispose()

        
        
        
    }
}
