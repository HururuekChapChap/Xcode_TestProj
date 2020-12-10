//
//  MenuViewModel.swift
//  RxSwift+MVVM
//
//  Created by yoon tae soo on 2020/12/10.
//  Copyright © 2020 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift

class MenuViewModel{
    
    var menus : [Menu] = [
        Menu(name: "뜀김", price: 100, count: 0),
        Menu(name: "뜀김", price: 100, count: 0),
        Menu(name: "뜀김", price: 100, count: 0),
        Menu(name: "뜀김", price: 100, count: 0),
        Menu(name: "뜀김", price: 100, count: 0),
        Menu(name: "뜀김", price: 100, count: 0)
        
    ]
    
    var itemCount : Int = 5
//    var totalPrice : Int = 200000
    
//    var totalPrice : Observable<Int> = Observable.just(20000)
    
    //publishSubject는 Observable과 달리 외부에서 부터 값을 받을 수 있다.
    //따라서 외부로 부터 입력을 받으면 그에 해당해서 값 변경이 가능하다.
    //또한 RxSwift의 장점은 한번 viewDidLoad에서 생성이 되면 Update() 함수를 지속적으로 호출할 필요가 없다.
    //한번 호출이 되면 이렇게 PublishSubject로 계속 값을 받을 수 있기 때문이고 계속 변경이 된다.
    var totalPrice : PublishSubject<Int> = PublishSubject<Int>()
}
