//
//  KindCollectionCellCollectionViewCell.swift
//  Ranfoo
//
//  Created by TOAD on 2022/02/12.
//

import UIKit

class KindCollectionCell: UICollectionViewCell {
    
    @IBOutlet var cellBubble: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var checkButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBubble.layer.cornerRadius = 20 // 모서리
        
        // shadow
        cellBubble.layer.shadowColor = UIColor.black.cgColor //색상
        cellBubble.layer.shadowOpacity = 0.05 //alpha값
        cellBubble.layer.shadowRadius = 0.05 //반경
        cellBubble.layer.masksToBounds = false //내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        cellBubble.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cellBubble.layer.cornerRadius).cgPath
        cellBubble.layer.shadowOffset = CGSize(width: 6, height: 6) //위치조정
    }
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        
    }
    
    override var isSelected: Bool {
      didSet {
        if isSelected {
            cellBubble.alpha = 0.3
        } else {
            cellBubble.alpha = 1
        }
      }
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        label.text = nil
//        
//    }

}
