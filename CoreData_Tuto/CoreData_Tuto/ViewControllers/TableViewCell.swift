//
//  TableViewCell.swift
//  CoreData_Tuto
//
//  Created by yoon tae soo on 2020/12/25.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let dataViewCell = "dataViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(){}
    
}

class dataViewCell : TableViewCell {
    
    let cellLabel : UILabel = {
        let label = UILabel()
        label.text = "Hello world"
        label.textColor = .brown
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func configureCell(){
        setLabelAutoLayout()
    }

}

extension dataViewCell {
    
    func setLabelAutoLayout(){
        contentView.addSubview(cellLabel)
        
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
}
