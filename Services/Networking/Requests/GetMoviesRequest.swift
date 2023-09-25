//
//  GetMoviesRequest.swift
//  Task
//
//  Created by A on 25/09/2023.
//

import Foundation

struct GetMoviesRequest {
    let currentPage: Int
}

extension GetMoviesRequest: NetworkRequest {
    
    var baseURL: String { NetworkConstants.baseURL }
    
    var path: String { "//3/discover/movie?api_key=\(NetworkConstants.apiKey)&page=\(currentPage)" }
    
    var method: HTTPMethod { .get }
    
    var headers: [String : String] { [:] }
    
    var bodyParameters: [String : Any] { [:] }
    
    var encodingType: EncodingType { .queryString }
    
    var authType: AuthType { .none }
    
    
    
}
