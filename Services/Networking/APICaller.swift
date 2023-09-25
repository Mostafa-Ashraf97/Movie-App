//
//  APICaller.swift
//  Task
//
//  Created by A on 05/09/2023.
//

import Foundation

class APICaller {
    static func fetchData<T:Codable >(url: URL, type: T.Type, completion: @escaping (Result <T, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //a3ml weak self hna brdu wla
            guard let data = data else {return}
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
