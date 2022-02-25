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
    @IBOutlet var storeUrlButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //listBubble
        listBubble.layer.cornerRadius = 15
        // shadow
        listBubble.layer.shadowColor = UIColor.black.cgColor //색상
        listBubble.layer.shadowOpacity = 0.2 //alpha값
        listBubble.layer.shadowRadius = 1 //반경
        listBubble.layer.shadowOffset = CGSize(width: 3, height: 3) //위치조정
        listBubble.layer.masksToBounds = false //내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        

//        storeKindLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        
        storeKindLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        storeKindLabel.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        storeKindLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
//        storeKindLabel.widthAnchor.constraint(equalToConstant: storeKindLabel.frame.width + storeKindLabel.layoutMargins.left + storeKindLabel.layoutMargins.right).isActive = true
        storeKindLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        storeKindLabel.backgroundColor = UIColor(named: Constants.thirdColor)
        storeKindLabel.layer.masksToBounds = true
        storeKindLabel.layer.cornerRadius = 5
        storeKindLabel.textAlignment = .center

    }
    
    @IBAction func storeUrlButtonPressed(_ sender: UIButton) {
        
//        if let url = URL(string: ListModel.storeUrlDict[storeNameLabel.text ?? ""] ?? Constants.kakaoMapUrl) { // 카카오 맵으로 연결되는 url
//            UIApplication.shared.open(url, options: [:])
//        }
        
//        let StoreVC = StoreListViewController()
//        
//        if let storeName = storeNameLabel.text {
//            StoreVC.webViewUrl = ListModel.storeUrlDict[storeName] ?? Constants.kakaoMapUrl
//        } else {
//            print("❗error. 가게 이름이 들어오지 않았음.")
//        }                
//        
//        StoreVC.performSegue(withIdentifier: Constants.webViewSegueIdentifier, sender: self)
        
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
