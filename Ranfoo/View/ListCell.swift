//
//  ListCell.swift
//  Ranfoo
//
//  Created by TOAD on 2022/02/03.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet var listBubble: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var checkButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
