//
//  MovieRepositories.swift
//  Task
//
//  Created by A on 25/09/2023.
//

import Foundation

class MovieRepository {
  private let client: HTTPClient

  init(client: HTTPClient) {
    self.client = client
  }

  func getMovies(page: Int) async throws -> Movies {
    let request = GetMoviesRequest(currentPage: page)
    let result = await client.execute(request)
    do {
      let (data, response) = try result.get()
      do {
        let movies = try MovieAPIResponseMapper<Movies>.map(response: response, data: data)
        return movies
      } catch {
        guard let error = error as? NetworkErrors else {
          throw NetworkErrors.parsingFailedError
        }
        print("error --> ", error)
        throw error
      }
    } catch {
      guard let error = error as? NetworkErrors else {
        throw NetworkErrors.parsingFailedError
      }
      print("error --> ", error)
      throw error
    }
  }
}
