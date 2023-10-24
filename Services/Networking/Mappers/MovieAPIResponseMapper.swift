//
//  MovieA.swift
//  Task
//
//  Created by A on 25/09/2023.
//

import Foundation

struct MovieAPIResponseMapper<T: Decodable> {
    
    private init() { }
    
    static func map(response: HTTPURLResponse, data: Data) throws -> T {
      let statusCode = response.statusCode
        guard statusCode == 200 || statusCode == 201 else {
          if data.isEmpty {
            throw NetworkErrors.noData
          } else {
            switch statusCode {
              case 1009, 1020:
                throw NetworkErrors.noInternetConnection
              case 404:
                throw NetworkErrors.notFound
              case 400, 401:
                throw NetworkErrors.notAuthorized
              case 500 ... 599:
                throw NetworkErrors.server
              default:
                throw NetworkErrors.unowned
            }
          }
        }
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
          throw NetworkErrors.parsingFailedError
        }
        return result
    }
}

enum NetworkErrors: Error {
  case noData
  case notFound
  case notAuthorized
  case server
  case invalidDataError
  case noInternetConnection
  case parsingFailedError
  case unowned
}
