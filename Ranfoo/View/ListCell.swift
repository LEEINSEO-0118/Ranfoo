//
//  ListCell.swift
//  Ranfoo
//
//  Created by TOAD on 2022/02/03.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet var listBubble: UIView!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var storeKindLabel: UILabel!
    @IBOutlet var storeLocationLabel: UILabel!
    @IBOutlet var storePhoneNumberLabel: UILabel!
    @IBOutlet var storeDistanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //listBubble
        listBubble.layer.cornerRadius = 15
        // shadow
        listBubble.layer.shadowColor = UIColor.black.cgColor //색상
        listBubble.layer.shadowOpacity = 0.2 //alpha값
        listBubble.layer.shadowRadius = 1 //반경
        listBubble.layer.shadowOffset = CGSize(width: 3, height: 4) //위치조정
        listBubble.layer.masksToBounds = false //내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        
//        //storeKindBackground
//        storeKindBackground.layer.cornerRadius = 5
//        //shadow
//        storeKindBackground.layer.shadowColor = UIColor.black.cgColor
//        storeKindBackground.layer.shadowOpacity = 0.3
//        storeKindBackground.layer.shadowRadius = 1
//        storeKindBackground.layer.shadowOffset = CGSize(width: 1, height: 1)
//        storeKindBackground.layer.masksToBounds = false
        
        
        storeKindLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        storeKindLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        storeKindLabel.backgroundColor = UIColor(named: Constants.thirdColor)
        storeKindLabel.layer.masksToBounds = true
        storeKindLabel.layer.cornerRadius = 5
        storeKindLabel.textAlignment = .center
        
//        let shadow = storeKindLabel.layer
//        shadow.masksToBounds = false
//        shadow.shadowColor = UIColor.black.cgColor //색상
//        shadow.shadowOpacity = 0.3 //alpha값
//        shadow.shadowRadius = 1
//        shadow.shadowOffset = CGSize(width: 1, height: 1) //위치조정
        

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        storeNameLabel.text = nil
    }
    
}
