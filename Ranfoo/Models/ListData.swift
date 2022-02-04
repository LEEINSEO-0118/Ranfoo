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
    let id: String
    let place_name: String
}
