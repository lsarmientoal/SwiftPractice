//
//  Movie.swift
//  ToolboxApp
//
//  Created by Laura Sarmiento Almanza on 10/12/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import Foundation

enum MovieType: String, Codable {
    case thumb, poster
}

struct Movie: Codable {
    
    struct Item: Codable  {
        let title: String
        let imageUrl: String
        let videoUrl: String?
        let description: String
    }
    
    let title: String
    let type: MovieType
    let items: [Item]
}

