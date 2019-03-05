//
//  URL+Helpers.swift
//  SpacePhoto
//
//  Created by Mark Meretzky on 3/3/19.
//  Copyright © 2019 New York University School of Professional Studies. All rights reserved.
//

import Foundation;

extension URL {   //p. 880
    func withQueries(_ queries: [String: String]) -> URL? {
        guard var components: URLComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil;
        }
        components.queryItems = queries.map {URLQueryItem(name: $0.0, value: $0.1)}
        return components.url;
    }
    
    func withHTTPS() -> URL? {   //p. 889
        guard var components: URLComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil;
        }
        components.scheme = "https";   //secure HTTP
        return components.url;
    }
}
