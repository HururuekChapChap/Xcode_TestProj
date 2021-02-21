//
//  WatchManager.swift
//  AppleWatchExample
//
//  Created by yoon tae soo on 2021/02/21.
//

import Foundation
import WatchConnectivity

class WatchManager : NSObject{
    
    static let shared : WatchManager = WatchManager()
    
    var watchSession : WCSession?
    
    override init(){
        
        super.init()
        
        if (!WCSession.isSupported()){
            watchSession = nil
            return
        }
        
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
        
    }
    
    func sendParamsToWatch(dict : [String : Any]){
        
        do{
            try watchSession?.updateApplicationContext(dict)
            print("send : \(dict)")
        }
        catch{
            print("Error sending dictionary \(dict) to Apple Watch")
        }
        
    }
    
    
}

extension WatchManager : WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("received message : \(message)")
    }

}
