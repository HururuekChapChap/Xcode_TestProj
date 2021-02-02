//
//  CameraViewController.swift
//  FullScreenCamera
//
//  Created by yoon tae soo on 2021/01/31.
//

import UIKit
import AVFoundation
import Photos

class CameraViewController: UIViewController {
    // TODO: 초기 설정 1
    
    //실시간으로 화면 데이터를 가져오는 방법
    let captureSession = AVCaptureSession()
    //captureSession으로 가져온 것을 화면으로 잡는 역할을 하는 놈
    var videoDeviceInput : AVCaptureDeviceInput!
    //사진의 결과를 출력한다.
    let photoOutput = AVCapturePhotoOutput()
    
    let sessionQueue = DispatchQueue(label: "session Queue")
    //입력으로 촬영된 영상이나 사진의 세션결과를 반환해주는 것 또는 하드웨어의 구체적인 특징을 설정해주는 것
    //DiscoverySession이 구체적인 설정을 해주는 것
    //deviceTypes : [카메라의 특징 설정] , mediaType : 결과물의 타입 - 영상 position : 카메라의 앞만 사용 설정 , 뒤만 사용 , 모두 사용
    let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera , .builtInTrueDepthCamera , .builtInUltraWideCamera , .builtInWideAngleCamera , .builtInTripleCamera], mediaType: .video, position: .unspecified)

    @IBOutlet weak var photoLibraryButton: UIButton!
    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var blurBGView: UIVisualEffectView!
    @IBOutlet weak var switchButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: 초기 설정 2
        
        //previewView에서는 현재 촬영하고 있는 상태를 보여준다.
        //아직 찍지는 않았지만 영상처럼 보이는 것
        //그리고 ViewDidload 시점에 preview의 session에 우리가 만든 captureSession을 넣어준다.
        //그래서 카메라에 영상 촬영을 하겠다고 알려준다.
        previewView.session = captureSession
        
        sessionQueue.async {
            self.setupSession()
            self.startSession()
        }
        
        setupUI()
        
        
    }
    
    //UI 설정
    func setupUI() {
        
        photoLibraryButton.layer.cornerRadius = 10
        photoLibraryButton.layer.borderWidth = 1
        photoLibraryButton.clipsToBounds = true
        photoLibraryButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        captureButton.layer.cornerRadius = captureButton.bounds.height/2
        captureButton.clipsToBounds = true
        
        blurBGView.layer.cornerRadius = blurBGView.bounds.height/2
        blurBGView.clipsToBounds = true
        
    }
    
    
    @IBAction func switchCamera(sender: Any) {
        // TODO: 카메라는 1개 이상이어야함
        
        // 핸드폰에 달려있는 카메라의 갯수
        if videoDeviceDiscoverySession.devices.count < 1 {
            return}
        
        // TODO: 반대 카메라 찾아서 재설정
        
        sessionQueue.async {
            //현재 비디오 촬영 카메라가 무엇인가?
            let currentVideoDevice = self.videoDeviceInput.device
            //그리고 그 카메라의 앞 뒤 전후가 어떻게 되는가?
            let currentPosition = currentVideoDevice.position
            //나를 보고 있는 카메라
            let isFront = currentPosition == .front
            //바꿀 포지션 - 앞이였다면 뒤로 보내고 뒤였다면 앞으로 보내고
            let preferredPosition : AVCaptureDevice.Position = isFront ? .back : .front
            
            //이제 그 해당하는 것 들 중에 해당하는 것을 해줄 거임
            let devices = self.videoDeviceDiscoverySession.devices
            //찾아주는 과정
            let newVideoDevice : AVCaptureDevice? = devices.first(where: { (device) -> Bool in
                return device.position == preferredPosition
            })
            
//            print(isFront , preferredPosition == .back)
            
            //이제 카메라를 변경 해준다.
            
            if let newDevice = newVideoDevice{
                
                do{
                
                    //디바이스 장치를 가져온다.
                    let newVideoDeviceInput = try AVCaptureDeviceInput(device: newDevice)
                    //카메라 세션을 변경을 해줄 것 임을 알려준다.
                    self.captureSession.beginConfiguration()
                    
                    //따라서 이렇게 미리 있는 세션을 제거 해준 다음에 넣어줘야 한다.
                    self.captureSession.removeInput(self.videoDeviceInput)
                    
                    //그리고 변경을 해준다. - 세션이 이미 하나 들어가 있으면 들어 갈 수가 없다.
                    if self.captureSession.canAddInput(newVideoDeviceInput){
                        self.captureSession.addInput(newVideoDeviceInput)
                        self.videoDeviceInput = newVideoDeviceInput
                        
                        //카메라 아이콘 변경
                        DispatchQueue.main.async {
                            self.updateSwitchCameraIcon(position: preferredPosition)
                        }
                        
                    }
                    else{
                        self.captureSession.addInput(self.videoDeviceInput)
                    }
                    
                    self.captureSession.commitConfiguration()
                
                }
                catch{
                    print("Error occured \(error.localizedDescription)")
                }
                
            }
            
            
            
        }
        
    }
    
    func updateSwitchCameraIcon(position: AVCaptureDevice.Position) {
        // TODO: Update ICON
        
        switch position {
        case .front:
            let image = #imageLiteral(resourceName: "ic_camera_front")
            switchButton.setImage(image, for: .normal)
        case .back:
            let image = #imageLiteral(resourceName: "ic_camera_rear")
            switchButton.setImage(image, for: .normal)
        default:
            break
        }
    }
    
    @IBAction func capturePhoto(_ sender: UIButton) {
        // TODO: photoOutput의 capturePhoto 메소드


    }
    
    
    func savePhotoLibrary(image: UIImage) {
        // TODO: capture한 이미지 포토라이브러리에 저장
    }
}


extension CameraViewController {
    // MARK: - Setup session and preview
    func setupSession() {
        // TODO: captureSession 구성하기
        // - presetSetting 하기
        // - beginConfiguration
        // - Add Video Input
        // - Add Photo Output
        // - commitConfiguration
        
        //캡처할 화면의 해상도를 무엇을 하겠는가? - 여러가지가 있지만 사진으로 하겠다.
        captureSession.sessionPreset = .photo
        //Session을 시작하겠다.
        captureSession.beginConfiguration()
        
        //위에 기준에 맞는 카메라들 중 가장 첫번째 요소를 가져온다....
        guard let camera = videoDeviceDiscoverySession.devices.first else {
            //카메라 Session을 종료한다.
            captureSession.commitConfiguration()
            return
        }
        
        do{
            //위에서 찾은 camera 디바이스에서 이제 세션으로 변경해준다.
            videoDeviceInput = try AVCaptureDeviceInput(device: camera)
            
            //위에서 얻은 세션을 진짜 카메라 세션에 넣을 수 있는가? 확인하고
            if captureSession.canAddInput(videoDeviceInput) {
                //그 다음에 넣을 수 있다면 넣어준다.
                captureSession.addInput(videoDeviceInput)
            }
            else{
                captureSession.commitConfiguration()
            }
            
        }
        catch{
            print(error.localizedDescription)
            captureSession.commitConfiguration()
        }
        
        
        //Add photo Output
        //결과물에 대한 타입을 설정하는 방법
        let outputType : AVCapturePhotoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
        //그럼 결과물을 내기 전에 타입 설정을 해주는 방법
        photoOutput.setPreparedPhotoSettingsArray([outputType], completionHandler: nil)
        
        //세션에 세견 결과물을 넣을 수 있니?
        if captureSession.canAddOutput(photoOutput){
            captureSession.addOutput(photoOutput)
        }
        else{
            captureSession.commitConfiguration()
        }
        
        captureSession.commitConfiguration()
        
    }
    
    
    
    func startSession() {
        // TODO: session Start
        
        //내일 이 부분 빼도 되는지 확인@@
//        sessionQueue.async {
            
            if !self.captureSession.isRunning{
                self.captureSession.startRunning()
            }
        
//        }
        
    }
    
    func stopSession() {
        // TODO: session Stop
        
//        sessionQueue.async {
            
            if self.captureSession.isRunning{
                self.captureSession.stopRunning()
            }
        
//        }
        
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // TODO: capturePhoto delegate method 구현
        
        
    }
}
