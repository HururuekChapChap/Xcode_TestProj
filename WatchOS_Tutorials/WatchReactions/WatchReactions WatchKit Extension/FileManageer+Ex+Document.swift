//
//  FileManageer+Ex+Document.swift
//  WatchReactions WatchKit Extension
//
//  Created by yoon tae soo on 2021/02/20.
//

import Foundation

extension FileManager{
    
    //파일을 저장하는 링크를 반환해준다.
    func getDocumentsDirectory() -> URL {
        
        let path = urls(for: .documentDirectory, in: .userDomainMask)
        
        print("get DocumentDirectory path : \(path)")
        
        return path[0]
        
    }
    
}
