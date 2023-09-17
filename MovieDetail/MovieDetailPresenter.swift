//
//  MovieDetailPresenter.swift
//  Task
//
//  Created by A on 24/08/2023.
//

import Foundation


protocol MovieDetailView: AnyObject{
    var presenter: MovieDetailPresenter? {get set}
    func setupDetailView(title: String, overview: String, imageUrl: URL)
}

class MovieDetailPresenter {
    weak var view: MovieDetailView?
    var movie: Movie
    
    init(view: MovieDetailView, movie: Movie){
        self.movie = movie
        self.view = view
    }
    
    func viewDidLoad() {
        let movieName = movie.name ?? movie.originalName ?? movie.title ?? ""
        let movieOverview = movie.overview ?? ""
        guard let moviePosterUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")") else {return}
        view?.setupDetailView(title: movieName, overview: movieOverview, imageUrl: moviePosterUrl)
        
    }
    
}
