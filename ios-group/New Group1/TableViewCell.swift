//
//  TableViewCell.swift
//  group_11
//
//  Created by Christopher on 20/05/2018.
//  Copyright © 2018 Christopher. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    let priceLabel :UILabel
    let describeLabel :UILabel
    let timeLabel:UILabel
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        
           priceLabel = UILabel(frame: CGRect.null)
        describeLabel = UILabel(frame: CGRect.null)
           timeLabel = UILabel(frame: CGRect.null)
        
         super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
