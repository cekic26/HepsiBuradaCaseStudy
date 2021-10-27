//
//  StoreItem.swift
//  HBCaseStudy
//
//  Created by Saide Cekic on 27.10.2021.
//

import Foundation

struct StoreItem: Codable {
    let name: String
    let artist: String
    var kind: String
    var artworkURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case kind
        case artworkURL = "artworkUrl100"
    }
   
}

struct SearchResponse: Codable {
    let results: [StoreItem]
}
