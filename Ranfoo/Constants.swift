//
//  Constants.swift
//  Ranfoo
//
//  Created by TOAD on 2022/02/03.
//

import Foundation

struct Constants {
    static let restApi = "688159a40aac51fd424e5742bd9a2d55"
    
    static let cellIdentifier = "listReusableCell"
    static let cellNibName = "ListCell"
    static let collectionCellIdentifier = "kindCollectionReusableCell"
    static let collectionCellNibName = "KindCollectionCell"
    
    static let kindViewSegueIdentifier = "goToKindView"
    static let storeListSegueIdentifier = "goToStoreList"
    static let webViewSegueIdentifier = "goToWebView"
    
    static let kakaoMapUrl = "http://place.map.kakao.com"
    
    static let secondColor = "second color"
    static let thirdColor = "third color"
    
    static let kindIconDefault = "kindIconDefault"
    static let kindIcon = [
        "한식": "koreanFood",
        "중식": "chineseFood",
        "일식": "japaneseFood",
        "양식": "westernFood",
        "분식": "boonsic",
        "치킨": "chicken",
        "아시아음식": "asianFood",
        "패스트푸드": "fastFood"
    ]
}
