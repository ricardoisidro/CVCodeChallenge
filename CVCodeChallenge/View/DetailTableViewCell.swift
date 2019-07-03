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
        contentView.addSubview(title)
        contentView.addSubview(detail)
        setConstraints()
        
    }
    
    private func setConstraints() {
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstraints.Title.leading).isActive = true
        title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: LayoutConstraints.Title.height).isActive = true
        title.widthAnchor.constraint(equalToConstant: LayoutConstraints.Title.width).isActive = true
        
        contentView.addConstraint(NSLayoutConstraint(item: detail, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1.0, constant: LayoutConstraints.Detail.trailing))
        detail.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        detail.heightAnchor.constraint(equalToConstant: LayoutConstraints.Detail.height).isActive = true
        detail.widthAnchor.constraint(equalToConstant: LayoutConstraints.Detail.width).isActive = true
        detail.textAlignment = .right
    }
}

