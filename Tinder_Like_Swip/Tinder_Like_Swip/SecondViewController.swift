//
//  SecondViewController.swift
//  Tinder_Like_Swip
//
//  Created by yoon tae soo on 2020/08/24.
//  Copyright © 2020 yoon tae soo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var CardView: UIView!
    @IBOutlet weak var RateImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetBtn(_ sender: Any) {
        resetCardView()
    }
    

    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        
        let cardView = sender.view!
        let point = sender.translation(in: view)
        cardView.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        let fromViewCenter = cardView.center.x - view.center.x
        
        let scale =  min (100/abs(fromViewCenter), 1 )
        
        cardView.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        if fromViewCenter > 0 {
            RateImageView.image = UIImage(systemName: "sun.max")
            RateImageView.tintColor = .systemRed
        }
        else{
            RateImageView.image = UIImage(systemName: "moon.stars.fill")
            RateImageView.tintColor = .systemYellow
        }
        
        RateImageView.alpha = abs( fromViewCenter ) / view.center.x
        
        if sender.state == UIPanGestureRecognizer.State.ended {
            
            if abs(fromViewCenter) > (view.center.x * 0.8) {
                let sign = fromViewCenter / abs(fromViewCenter)
                
                UIView.animate(withDuration: 0.3) {
                    cardView.center = CGPoint(x: cardView.center.x + 200 * sign, y: cardView.center.y + 80)
                    self.CardView.alpha = 0
                }
                
                return
            }
            
            resetCardView()
        
        }
        
    }
    
    func resetCardView(){
        
        UIView.animate(withDuration: 0.3) {
            self.CardView.center = self.view.center
            self.RateImageView.alpha = 0
            self.CardView.alpha = 1
            self.CardView.transform = .identity
        }
        
    }

}
