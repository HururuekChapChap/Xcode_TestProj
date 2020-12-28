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
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
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
        createMessage(friend: newFriend, pluse: 1.0, detail: "Hello World")
        createMessage(friend: newFriend, pluse: 1.5, detail: "How are you?")
        createMessage(friend: newFriend, pluse: 2.0, detail: "I'm Fine")
        
        
        newFriend = Friend(context: context)
        newFriend.name = "ChapChap"
        createMessage(friend: newFriend, pluse: 3.0, detail: "Hello?")
        
        newFriend = Friend(context: context)
        newFriend.name = "Trump"
        createMessage(friend: newFriend, pluse: 4.0, detail: "Hello?")
      
        
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
    
    private func createMessage(friend : Friend , pluse : Double , detail : String){
        
        let newMessage = Message(context : context)
        newMessage.date = Date().addingTimeInterval(pluse * 60)
        newMessage.detail = detail
        newMessage.chat_friend = friend
        
        friend.addToChat_message(newMessage)
        
        do{
            try context.save()
        }
        catch let err{
            context.rollback()
            print(err.localizedDescription)
        }
        
    }
    
}
