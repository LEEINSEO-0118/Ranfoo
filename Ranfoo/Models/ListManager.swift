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

enum MyError: Error {
    case decodingError
    case networkError
}

class ListManager {
    
    //MARK: - Singleton
    
    static let shared: ListManager = ListManager()
    public init() {}
    
    //MARK: - Delegate
    
    var delegate: ListManagerDelegate?  // delagate에 ? 를 붙여주지 않았더니 init이 제대로 되지 않아다며 error 발생.
    
    //MARK: - URL, Header 및 객체
    
    let url = "https://dapi.kakao.com/v2/local/search/keyword.json?"
    let headers: HTTPHeaders = [ "Authorization" : "KakaoAK \(Private.restApi)" ]
    
    var parameters: [String: String] = ["query": ""]
    
    //MARK: - 장소 list request
    
    func getList(lat: CLLocationDegrees, lon: CLLocationDegrees, keyword: String,
                 completion: @escaping ((Result<Bool, Error>) -> Void)) {
        
        parameters["query"] = keyword
        
        AF.request("\(url)y=\(lat)&x=\(lon)&sort=distance&radius=500",
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
                        
                        for document in decodedData.documents {
                            print("식당 이름: \(document.place_name)")
                            print("식당 링크: \(document.place_url)")
                            ListModel.storeListKeyArray.append(document.place_name)
                            ListModel.storeUrlDict.updateValue(document.place_url, forKey: document.place_name)
                            ListModel.storeKindDict.updateValue(keyword, forKey: document.place_name)
                            ListModel.storeLocationDict.updateValue(document.road_address_name, forKey: document.place_name)
                            ListModel.storePhoneDict.updateValue(document.phone, forKey: document.place_name)
                            ListModel.storeDistanceDict.updateValue(document.distance, forKey: document.place_name)
                        }
                        completion(.success(true))
                        
                    } catch {
                        print("FILE MANAGER - searchFileFolder() Error decoding: \(error)")
                        completion(.failure(MyError.decodingError))
                    }
                    print("Validation Successful")
                case let .failure(error):
                    completion(.failure(MyError.networkError))
                    print(error)
                }
            }
    }
    
}





