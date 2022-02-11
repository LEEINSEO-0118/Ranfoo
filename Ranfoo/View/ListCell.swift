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
        
        listBubble.layer.cornerRadius = listBubble.frame.size.height / 4
        
        // shadow
        listBubble.layer.shadowColor = UIColor.black.cgColor //색상
        listBubble.layer.shadowOpacity = 0.3 //alpha값
        listBubble.layer.shadowRadius = 5 //반경
        listBubble.layer.shadowOffset = CGSize(width: 0, height: 10) //위치조정
        listBubble.layer.masksToBounds = false //내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        checkButton.isHidden = true
        
    }
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
    
        if checkButton.isHidden == false {
            checkButton.isHidden = true
        } else {
            checkButton.isHidden = false
        }
        
    }
    
}
