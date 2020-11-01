//
//  SampleViewController.swift
//  NastedScrollView
//
//  Created by yoon tae soo on 2020/11/01.
//

import UIKit

class SampleViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var text : UILabel!
    let viewModel = ViewListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingCollectionViewDelegate()
        viewModel.fetchItems()
    }
    
    override func viewDidLayoutSubviews() {
        
        text.text = viewModel.currentType.title
        
    }
    
}

extension SampleViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func settingCollectionViewDelegate(){
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleViewControllerCell", for: indexPath) as? SampleViewControllerCell else {return UICollectionViewCell()}
        
        let color = viewModel.getItem(index: indexPath.row)
        cell.updateBackGroundColor(item: color)
        
        return cell
    }
    
    
}

extension SampleViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: collectionView.frame.height)
    }
    
}

class SampleViewControllerCell : UICollectionViewCell{
    
    
    func updateBackGroundColor(item : UIColor){
        
        self.contentView.backgroundColor = item
        
    }
    
}

class ViewListModel {
    
    enum ViewType{
        case one
        case two
        
        var title : String {
            
            switch self {
            case .one :
                return "빨주노초"
            
            case .two :
                return "파갈보빨"
            }
            
        }
        
    }
    
    private (set) var currentType : ViewType = .one
    private var items : [UIColor] = []
    
    var numberOfItem : Int {
        return items.count
    }
    
    func getItem(index : Int) -> UIColor {
        return items[index]
    }
    
    func updateType(type : ViewType){
        currentType = type
    }
    
    func fetchItems(){
        items = ColorFetcher.fetchColor(type: self.currentType)
    }

}

struct ColorFetcher {
    
    init(){
        print("generate ColorFetcher")
    }
    
    static func fetchColor(type : ViewListModel.ViewType) -> [UIColor]{
        
        var color : [UIColor] = []
        
        switch type {
        case .one:
            color = [.red , .orange, .yellow, .green]
        default:
            color = [.blue, .brown , .purple, .cyan]
        }
        
        return color
    
    }

}
