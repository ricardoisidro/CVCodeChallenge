//
//  DetailTableViewCell.swift
//  CVCodeChallenge
//
//  Created by Ricardo Isidro Ramirez on 7/1/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    let title = UILabel()
    let detail = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        detail.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(title)
        self.contentView.addSubview(detail)
        setConstraints()
        
    }
    
    private func setConstraints() {
        title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        title.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 30).isActive = true
        title.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        contentView.addConstraint(NSLayoutConstraint(item: detail, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1.0, constant: 10))
        detail.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        detail.heightAnchor.constraint(equalToConstant: 30).isActive = true
        detail.widthAnchor.constraint(equalToConstant: 180).isActive = true
        detail.textAlignment = .right
    }
}

