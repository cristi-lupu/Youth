//
//  Request+NetworkRequestCancelable.swift
//  Youth
//
//  Created by Lupu Cristian on 5/27/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Alamofire

extension Request: NetworkRequestCancelable {

    public func cancelRequest() {
         cancel()
    }

}
