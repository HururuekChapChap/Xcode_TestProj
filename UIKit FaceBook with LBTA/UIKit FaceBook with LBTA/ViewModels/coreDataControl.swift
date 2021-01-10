//
//  coreDataControl.swift
//  UIKit FaceBook with LBTA
//
//  Created by yoon tae soo on 2020/12/28.
//

import UIKit
import CoreData

class coreDataControl {
    
    static let shared = coreDataControl()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func getAllMessages() -> [Message]?{
        
            guard let friends = getAllFriends() else {return nil}
            
            var messages : [Message] = []
            
            friends.forEach { (friend) in
                
                do{
                    
                let fetchRequest : NSFetchRequest<Message> = Message.fetchRequest()
                // 시간이 작은 것(오래된 것)이 먼저 오게 된다
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
                fetchRequest.predicate = NSPredicate(format: "chat_friend.name = %@", friend.name!)
                fetchRequest.fetchLimit = 1
    //            let items = try context.fetch(Message.fetchRequest())
    //            let message = items as! [Message]
                
                let message = try context.fetch(fetchRequest)
                    
                    messages.append(contentsOf: message)
                    
                }
                catch let err {
                    print(err.localizedDescription)
                }
            }
        
        messages = messages.sorted(by: { (mess1, mess2) -> Bool in
            return mess1.date! > mess2.date!
        })
        
        return messages.isEmpty ? nil : messages
        
    }
    
    private func getAllFriends() -> [Friend]?{
        
        do{
            let items = try context.fetch(Friend.fetchRequest())
            if let friends = items as? [Friend] {
            
                return friends
            }
        }
        catch let err{
            print(err.localizedDescription)
        }
        
        return nil
    }
    
    func saveSomeMessage(){
        
        cleareAllData()
        
        var newFriend = Friend(context: context)
        newFriend.name = "Hruruek"
        createMessage(friend: newFriend, pluse: -4.0 * 60, detail: "Hello World")
        createMessage(friend: newFriend, pluse: -3.5 * 60, detail: "How are you?")
        createMessage(friend: newFriend, pluse: -2.0 * 60, detail: "I'm Fine")
        createMessage(friend: newFriend, pluse: -1.0 * 60, detail: "저도 완전 최곱니다. ㅎ하하ㅏ하하하하하하하ㅏ하핳 Every Thing is 굿굿!! 유노 왓암 셍? 호호 하하 최고다 아오~~!!")
        createMessage(friend: newFriend, pluse: -0.8 * 60, detail: "How are you?", isSender: true)
        createMessage(friend: newFriend, pluse: -0.7 * 60, detail: "How are you? How are you?1")
        createMessage(friend: newFriend, pluse: -0.6 * 60, detail: "How are you? How are you?2")
        createMessage(friend: newFriend, pluse: -0.5 * 60, detail: "How are you? How are you?3", isSender: true)
        createMessage(friend: newFriend, pluse: -0.4 * 60, detail: "How are you?1", isSender: true)
        createMessage(friend: newFriend, pluse: -0.3 * 60, detail: "How are you?2")
        createMessage(friend: newFriend, pluse: -0.2 * 60, detail: "How are you?3", isSender: true)
        createMessage(friend: newFriend, pluse: -0.1 * 60, detail: "How are you?4", isSender: true)
        
        
        newFriend = Friend(context: context)
        newFriend.name = "ChapChap"
        createMessage(friend: newFriend, pluse: -3.0 * 60, detail: "Hello?")
        
        newFriend = Friend(context: context)
        newFriend.name = "트럼프"
        createMessage(friend: newFriend, pluse: -4.0 * 60, detail: "Your Fire!")
        
        newFriend = Friend(context: context)
        newFriend.name = "이명박"
        createMessage(friend: newFriend, pluse: -1 * ((60 * 24 * 60) + (60 * 10)), detail: "여러분 이거 다 거짓말")
      
        newFriend = Friend(context: context)
        newFriend.name = "박근혜"
        createMessage(friend: newFriend, pluse: -1 * ((60 * 24 * 60) * 8), detail: "허허허허")
        
    }
    
    private func cleareAllData(){
        
        do{
            
            let items = try context.fetch(Friend.fetchRequest())
            let friends = items as! [Friend]
            
            for friend in friends {
                context.delete(friend)
            }
            
            try context.save()
            
        }
        catch let err{
            print(err.localizedDescription)
        }
        
    }
    
    @discardableResult
    func createMessage(friend : Friend , pluse : Double , detail : String, isSender : Bool = false) -> Message{
        
        let newMessage = Message(context : context)
        newMessage.date = Date().addingTimeInterval(pluse)
        newMessage.detail = detail
        newMessage.chat_friend = friend
        newMessage.isSender = isSender
        
        friend.addToChat_message(newMessage)
        
        do{
            try context.save()
        }
        catch let err{
            context.rollback()
            print(err.localizedDescription)
        }
        
        return newMessage
        
    }
    
}
