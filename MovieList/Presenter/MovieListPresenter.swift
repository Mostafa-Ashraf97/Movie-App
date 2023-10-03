//
//  MovieListPresenter.swift
//  Task
//
//  Created by A on 07/08/2023.
//

import Foundation

class MovieListPresenter {
    
    weak var view: MovieView?
    var router: MovieListVCRouter
    var movies : [Movie] = []
    var currentPage = 1
    var totalPages = 1
    
    let tokenManager = TokenManager()
    lazy var client = AlamofireHTTPClient(tokenManager: tokenManager)
    lazy var respository = MovieRepository(client: client)
    lazy var movieRepository = MovieRepository(client: client)
    
    
    init(view: MovieView?, router: MovieListVCRouter) {
        self.view = view
        self.router = router
    }
    
    func fetchData() {
        Task {
            do {
                let results = try await movieRepository.getMovies(page: currentPage)
                guard let movies = results.results else {return}
                self.movies.append(contentsOf: movies)
                self.totalPages = results.totalPages ?? 1
                DispatchQueue.main.async {
                    self.view?.fetchDataSuccess()
                }
                currentPage += 1
            } catch {
                print("Error ", error.localizedDescription)
            }
        }
    }
    
    func returnMoviesCount() -> Int {
        movies.count
    }
    
    func movieModel(for indexPath: IndexPath) -> MovieViewItem? {
        let movie = movies[indexPath.row]
        let posterPath = movie.posterPath ?? ""
        guard let moviePosterUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        else {
            print("Error Parsing URL")
            return nil
        }
        return MovieViewItem(
            name: movie.name ?? movie.originalName ?? movie.title ?? "",
            imageURL: moviePosterUrl)
    }
    
    func didSelectRowAt(row: Int) {
        let movie = movies[row]
        router.navigateToMovieDetailVC(movie: movie, view: view)
    }
    
    func willDisplayAt(row: Int) {
        if row == movies.count - 1 , currentPage < totalPages {
            fetchData()
        }
    }
}
