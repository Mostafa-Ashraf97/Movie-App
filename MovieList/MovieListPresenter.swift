//
//  MovieListPresenter.swift
//  Task
//
//  Created by A on 07/08/2023.
//

import Foundation

protocol MovieView : AnyObject {
    var presenter : MovieListPresenter? {get set}
    func fetchDataSuccess()
    func fetchDataFailed(error: String)
}

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
    
    
    //    func loadData() {
    //        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=78ebc7dcbb138a974637b43f956efbdc&page=\(currentPage)") else {return}
    //
    //        APICaller.fetchData(url: url, type: Movies.self) { [weak self] results in
    //            switch results {
    //            case .success(let movie) :
    //                guard let movies = movie.results else {return}
    //                self?.movies.append(contentsOf: movies)  // tmam kda wla
    //                self?.totalPages = movie.totalPages ?? 1   // feh 7l badel ?
    //                DispatchQueue.main.async {
    //                    self?.view?.fetchDataSuccess()
    //                }
    //
    //            case .failure(let error) :
    //                self?.view?.fetchDataFailed(error: error.localizedDescription)
    //            }
    //        }
    //        currentPage += 1
    //            }
    
    func returnMoviesCount() -> Int {
        movies.count
    }
    
    func movieModel(for indexPath: IndexPath) -> MovieViewItem {
        let movie = movies[indexPath.row]
        
        guard let moviePosterUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")") else {return MovieViewItem(name: "", imageURL: URL(string: "")! ) }
        return MovieViewItem(
            name: movie.name ?? movie.originalName ?? movie.title ?? "",
            imageURL: moviePosterUrl)
        //l mafrod aktb 7aga bdl l string l fady da t2ol msln error aw can't find movie aw aii 7aga wla empty string da ishta
        //ashel al force unwrap hna azaii
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

struct MovieViewItem {       //a7ot da hna wla f file al model
    var name: String
    var imageURL: URL
}
