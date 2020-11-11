//
//  ViewController.swift
//  CoreBluetooth_Tuto
//
//  Created by yoon tae soo on 2020/11/11.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    //peripherals = 주변장치의
    //주변 장치에 연결 관라 등을 담당
    var centralManager: CBCentralManager!
    
    //원격 주변 장치 연결
    var myPeripheral: CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The possible states of a Core Bluetooth manager. - 블루투스 관리자의 가능 상태
        //centralManger는 관라자를 의미하는데 그것을 이 뷰컨트롤러로 delegate 연결로 위임한다.
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        // Do any additional setup after loading the view.
    }


}


extension ViewController : CBCentralManagerDelegate{
    
    //블루투스가 켜져 있는지 꺼져 있는지 확인
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == CBManagerState.poweredOn {
            print("BLE powered on")
                    // Turned on
            central.scanForPeripherals(withServices: nil, options: nil)
        }
        else {
            print("Something wrong with BLE")
                    // Not on, but can have different issues
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if let pname = peripheral.name {
           print(pname)
            if pname == "raspberrypi" {
                            
                print("discover peripheral : \(peripheral)")
                self.myPeripheral = peripheral
                self.myPeripheral.delegate = self
                self.centralManager.connect(peripheral, options: nil)
                self.centralManager.stopScan()
                
                        }
           
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        if let hasError = error {
            
            print(hasError)
            
        }
        else{
            print("Success Connect")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.myPeripheral.discoverServices(nil)
        
        print("Connect Device")
        print(myPeripheral.name)
        
        }
    
    func peripheral(peripheral: CBPeripheral?, didUpdateValueForCharacteristic characteristic: CBCharacteristic?, error: NSError!) {
           
           if let characteristicValue = characteristic?.value{
            let datastring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue)
            
               if let datastring = datastring{
//                   navigationItem.title = datastring as String
                
                    print(datastring as String)
                
               }
           }
       }
    
}

extension ViewController : CBPeripheralDelegate  {
    
}
