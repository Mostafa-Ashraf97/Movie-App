//
//  MovieListPresenter.swift
//  Task
//
//  Created by A on 07/08/2023.
//

import Foundation

protocol MovieView : AnyObject {
    func fetchDataSuccess()
    func fetchDataFailed(error: String)
}

class MovieListPresenter {
    
    weak var view : MovieView?
    var movies : [Title] = []
    
    init(_ view: MovieView) {
        self.view = view
    }
    
    func movieViewDidLoad() {
        fetchData { [weak self] results in
            switch results {
            case .success(let movies) :
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.view?.fetchDataSuccess()
                }
            case .failure(let error) :
                self?.view?.fetchDataFailed(error: error.localizedDescription)
            }
        }
    }
    
    func fetchData(completion: @escaping (Result <[Title], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=78ebc7dcbb138a974637b43f956efbdc") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            do {
                let results = try JSONDecoder().decode(Movies.self, from: data)
                guard let titles = results.results else {return}
                completion(.success(titles))

            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    func returnMoviesCount() -> Int {
        movies.count
    }
    
//    func returnMovieCell(with cell: MovieCell, at row: Int) {
//        let model = movies[row]
//        let movieName = model.name ?? model.originalName ?? model.title ?? ""
//        let posterUrl = "https://image.tmdb.org/t/p/w500/\(model.posterPath)"
//        guard let imageUrl = URL(string: posterUrl) else {return}
//
//        cell.configure(text: movieName, image: imageUrl)
//    }
    
    func movieModel(for indexPath: IndexPath) -> MovieViewItem {
        let movie = movies[indexPath.row]
        return MovieViewItem(
            name: movie.name ?? movie.originalName ?? movie.title ?? "",
            imageURL: movies[indexPath.row].posterPath  ?? ""
        )
    }
    
}

struct MovieViewItem {
    var name: String
    var imageURL: String
}
