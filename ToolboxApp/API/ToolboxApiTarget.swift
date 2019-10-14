//
//  ToolboxApiTarget.swift
//  ToolboxApp
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import Foundation
import Moya

enum ToolboxApiTarget {
    
    case authorization
    case movies
}

extension ToolboxApiTarget: TargetType {
    var baseURL: URL {
        URL(string: "https://echo-serv.tbxnet.com")!
    }
    
    var path: String {
        switch self {
        case .authorization:
            return "/v1/mobile/auth"
        case .movies:
            return "/v1/mobile/data"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authorization:
            return .post
        case .movies:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .authorization:
            return .requestParameters(parameters: ["sub" : "ToolboxMobileTest"], encoding: JSONEncoding.default)
        case .movies:
            return .requestPlain
        }
        	
    }
    
    var headers: [String : String]? {
        var headers: [String : String] = [:]
        if let token = UserDefaults.standard.string(forKey: "authToken"), let type = UserDefaults.standard.string(forKey: "authType") {
            headers["Authorization"] = "\(type) \(token)"
        }
        
        return headers
    }
    
    
}


