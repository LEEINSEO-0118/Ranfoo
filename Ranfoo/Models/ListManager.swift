//
//  ListManager.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/31.
//

import Foundation
import UIKit
import Alamofire
import CoreLocation

struct ListManager {
    
    let keyword: String = ""
    
    static let headers: HTTPHeaders = [ "Authorization" : "KakaoAK 688159a40aac51fd424e5742bd9a2d55" ]
    static let url = "https://dapi.kakao.com/v2/local/search/category.json?"
    
    static let parameters: [String: Any] = [
        "query": "카카오프렌즈"
    ]
    
    func fetchList(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        getList(lat: latitude, lon: longitude)
    }
    
    func getList(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        
        AF.request("\(ListManager.url)y=\(lat)&x=\(lon)&category_group_code=PM9&radius=20000",
                   method: .get,
//                   parameters: ListManager.parameters,
                   headers: ListManager.headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    do {
                        let decodedData = try JSONDecoder().decode(ListData.self, from: response.data!)
                        print(decodedData.documents[0].place_name)
                    } catch { print("FILE MANAGER - searchFileFolder() Error decoding: \(error)") }
                    print("Validation Successful")
                case let .failure(error):
                    print(error)
                }
            }
    }

    
}




//AF.request(
//    ListManager.url,
//    method: .get,
//    parameters: ListManager.parameters,
//    headers: ListManager.headers
//).response { response in
//    print(response)
//}.resume()
