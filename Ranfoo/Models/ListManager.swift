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

//MARK: - api를 통해 가져온 가게 정보를 StoreListVC에 업데이트 해준다.
protocol ListManagerDelegate {
    func didUpdateStore(store: ListModel)
}

//MARK: - Kakao Local api 를 통해 정보를 가게 정보를 가져온다.
class ListManager {
    
    //MARK: - Singleton
    static let shared: ListManager = ListManager()
    public init() {}
    //MARK: - Delegate
    var delegate: ListManagerDelegate?  // delagate에 ? 를 붙여주지 않았더니 init이 제대로 되지 않아다며 error 발생.
    
    //MARK: - URL, Header 및 객체
    let url = "https://dapi.kakao.com/v2/local/search/keyword.json?"
    let headers: HTTPHeaders = [ "Authorization" : "KakaoAK 688159a40aac51fd424e5742bd9a2d55" ]
    
    let keyword: String = "중식"
    var parameters: [String: String] = ["query": ""]
    
    //MARK: - 장소 list request
    func fetchList(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        parameters["query"] = keyword
        getList(lat: latitude, lon: longitude)
    }
    
    func getList(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        
        AF.request("\(url)y=\(lat)&x=\(lon)&sort=distance&radius=2000",
                   method: .get,
                   parameters: parameters,
                   headers: headers)
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





