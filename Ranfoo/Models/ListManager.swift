//
//  ListManager.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/31.
//

import Foundation
import UIKit
import Alamofire

struct ListManager {
    
    let listData = ListData()
    
    static let headers: HTTPHeaders = [ "Authorization" : "KakaoAK 688159a40aac51fd424e5742bd9a2d55" ]
    
    static let parameters: [String: Any] = [
        "query": "keyword"
    ]
    
    func getList() {
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json", method: .get, parameters: ListManager.parameters, headers: ListManager.headers)
            .validate()
    }
        

    
}
