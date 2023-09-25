//
//  AlamofireHTTPClient.swift
//  Task
//
//  Created by A on 25/09/2023.
//

import Foundation
import Alamofire

protocol HTTPClient {
    func execute(_ request: NetworkRequest) async -> Result<(Data, HTTPURLResponse), Error>
}

class AlamofireHTTPClient: HTTPClient {
    private let session = Session(eventMonitors: [AlamofireRequestLogger()])
    private let tokenManager: TokenManager
    
    init(tokenManager: TokenManager) {
        self.tokenManager = tokenManager
    }
    
    func execute(_ request: NetworkRequest) async -> Result<(Data, HTTPURLResponse), Error> {
        do {
            let request = AlamofireRequest(from: request, tokenManager: tokenManager)
            let dataRequest = session.request(request)
            let data = try await dataRequest.serializingData().value
            guard let response = dataRequest.response else {
                throw InvalidResponseError()
            }
            return .success((data, response))
        } catch {
            return .failure(error)
        }
    }
    
    private struct InvalidResponseError: LocalizedError { }
}
