//
//  AuthToken.swift
//  ToolboxApp
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import Foundation

struct AuthToken: Codable {
    let sub: String
    let token: String
    let type: String
}
