//
//  ContentView.swift
//  codeTutorial_watchOS_listBase WatchKit Extension
//
//  Created by yoon tae soo on 2021/02/20.
//

import SwiftUI

struct Person : Identifiable{
    var id = UUID()
    var name : String
    var age: Int
}

struct ContentView: View {
    
    
    var people : [Person] = [
        Person(name: "Chris", age: 50),
        Person(name: "Lauren", age: 40),
        Person(name: "Steve", age: 30),
        Person(name: "Luck", age: 20),
        Person(name: "Andrew", age: 10),
    
    ]
    @State var selectedPerson : Person?
    
    var body: some View {
        List{
            ForEach(0..<5){_ in
                    Text("aaaaaa")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
