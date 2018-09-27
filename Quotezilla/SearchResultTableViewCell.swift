//
//  SearchResultTableViewCell.swift
//  Quotezilla
//
//  Created by Abhishek Mahesh on 7/30/15.
//  Copyright (c) 2015 AbsTech. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var searchResultTextView: UITextView! = UITextView()
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
