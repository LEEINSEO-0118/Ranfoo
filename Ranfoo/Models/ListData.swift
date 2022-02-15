//
//  ListData.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/31.
//

import Foundation

struct ListData: Codable {
    let documents: [Documents]    
}

struct Documents: Codable {
    
    let place_name: String
    let place_url: String
    let road_address_name: String
    let phone: String
    let distance: String
    
}
