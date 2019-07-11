//
//  MyTableViewCell.swift
//  MyFirstApp
//
//  Created by Zomato on 11/07/19.
//  Copyright © 2019 Zomato. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let mainImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        contentView.addSubview(mainImageView)
        mainImageView.set(.leading(contentView, 12),
                          .top(contentView, 12),
                          .bottom(contentView, 12),
                          .height(40),
                          .width(40))
        mainImageView.layer.cornerRadius = 20
        mainImageView.clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        titleLabel.set(.after(mainImageView, 12),
                       .top(mainImageView),
                       .trailing(contentView, 12))
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.set(.below(titleLabel, 2),
                          .sameLeadingTrailing(titleLabel))
    }
    
    public func setData(user: User, image: Data) {
        mainImageView.image = UIImage(data: image)
        titleLabel.text = user.name
        subtitleLabel.text = user.email
    }
    
}
