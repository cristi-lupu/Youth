//
//  UnsplashRateLimit.swift
//  Youth
//
//  Created by Cristian Lupu on 4/25/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    /**
     Rate Limiting

     For applications in demo mode, the Unsplash API currently places a limit of 50 requests per hour.
     After approval for production, this limit is increased to 5000 requests per hour.

     - Note: Note that only the json requests (i.e., those to api.unsplash.com) are counted.
     Image file requests (images.unsplash.com) do not count against your rate limit.
     */
    struct RateLimit {
        /// Total limit count
        let totalLimit: Int64

        /// Total remaining count
        let remaining: Int64

        /**
         Create rate limit

         - parameter response: Response from http request

         - returns: `Optional` RateLimit
         */
        static func rateLimit(from response: HTTPURLResponse?) -> RateLimit? {
            let headerFields = response?.allHeaderFields

            guard let stringTotalLimit = headerFields?["x-ratelimit-limit"] as? String,
                let stringRemaining = headerFields?["x-ratelimit-remaining"] as? String,
                let integerTotalLimit = Int64(stringTotalLimit),
                let integerRemaining = Int64(stringRemaining) else {
                    return nil
            }

            return RateLimit(totalLimit: integerTotalLimit,
                             remaining: integerRemaining)
        }
    }
}
