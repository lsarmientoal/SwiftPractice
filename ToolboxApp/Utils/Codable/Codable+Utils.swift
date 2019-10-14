//
//  Codable+Utils.swift
//  Pokedex
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import Foundation

extension Decodable {
    
    init?(JSON: [String: Any]) {
        let decoder = JSONDecoder()
        guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted),
            let object = try? decoder.decode(Self.self, from: data) else { return nil}
        self = object
    }

    init?(JSONObject: Any?) {
        guard let JSON = JSONObject as? [String: Any],
            let object = Self.init(JSON: JSON) else { return nil}
        self = object
    }
    
    init?(JSONString: String) {
        let decoder = JSONDecoder()
        guard let data = JSONString.data(using: .utf8),
            let object = try? decoder.decode(Self.self, from: data) else { return nil}
        self = object
    }
}

extension Encodable {
    
    func toJSON() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return [:] }
        return json
    }
    
    func toJSONString(prettyPrint: Bool = false) -> String? {
        let encoder = JSONEncoder()
        var ouputFormatting: [JSONEncoder.OutputFormatting] = []
        if prettyPrint {
            ouputFormatting.append(.prettyPrinted)
        }
        if #available(iOS 13.0, *) {
            ouputFormatting.append(.withoutEscapingSlashes)
        }
        guard let data = try? encoder.encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Array where Element: Decodable {
    
    init?(JSONArray array: [[String: Any]]) {
        self = array.compactMap {  Element.init(JSON: $0) }
    }
}
