//
//  Request+NetworkRequestCancelable.swift
//  Youth
//
//  Created by Cristian Lupu on 5/27/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Alamofire

extension Request: NetworkRequestCancelable {
    
    func cancelRequest() {
        cancel()
    }
    
}
