//
//  Pagination.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

struct Pagination {
    let page: Int
    let perPage: Int
}

extension Pagination: ParametersConvertible {
    var parameters: [String: Any] {
        return ["page": page, "per_page": perPage]
    }
}
