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
              throw NetworkErrors.invalidDataError
            }
            return .success((data, response))
        } catch {
          if let errorCode = (error.asAFError?.underlyingError as? NSError)?.code {
            let statusCode = URLError.Code(rawValue: errorCode)
            switch statusCode {
              case .notConnectedToInternet, .networkConnectionLost:
                return .failure(NetworkErrors.noInternetConnection)
              default:
                return .failure(NetworkErrors.unowned)
            }
          } else {
               return .failure(NetworkErrors.notFound)
          }
        }
    }
}
