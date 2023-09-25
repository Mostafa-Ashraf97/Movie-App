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
        let (data, response) = try result.get()
        return try MovieAPIResponseMapper.map(response: response, data: data)
    }
    
}
