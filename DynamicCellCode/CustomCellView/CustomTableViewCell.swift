//
//  CustomTableViewCell.swift
//  DynamicCellCode
//
//  Created by Niharika on 31/07/19.
//  Copyright © 2019 Niharika. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var nameLabel = UILabel()
    var detailLabel = UILabel()
    var profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()
    
    var minHeight: CGFloat = 80.0
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        let minHeight = self.minHeight
        return CGSize(width: size.width, height: max(size.height, minHeight))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false;
        contentView.addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant:100).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant:5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant:-10).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant:-10).isActive = true
        detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont(name: "Avenir-Book", size: 12)
        detailLabel.textColor = UIColor.lightGray
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

