//
//  String+Utils.swift
//  ToolboxApp
//
//  Created by Laura Sarmiento Almanza on 10/13/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import Foundation

extension String {
    func toUrl() -> URL? {
        URL(string: self)
    }
}
