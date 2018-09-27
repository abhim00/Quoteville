//
//  QuoteTableViewCell.swift
//  Quotezilla
//
//  Created by Abhishek Mahesh on 7/18/15.
//  Copyright (c) 2015 AbsTech. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    var parseObject : PFObject?

    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet var publisherLabel: UILabel! = UILabel()
    
    @IBOutlet var timeStampLabel: UILabel! = UILabel()
    
    @IBOutlet var contentTextView: UITextView! = UITextView()
    
    @IBOutlet var likesLabel: UILabel!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextView.userInteractionEnabled = true
        contentTextView.editable = false
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
