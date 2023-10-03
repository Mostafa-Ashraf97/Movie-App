//
//  MovieDetailVCRouter.swift
//  Task
//
//  Created by A on 24/08/2023.
//

import UIKit

class MovieDetailVCRouter {
    
    static func createMovieDetailVC(movie: Movie) -> UIViewController {
        let movieDetailVC = MovieDetailViewController()
        let movieDetailPresenter = MovieDetailPresenter(view: movieDetailVC, movie: movie)
        movieDetailVC.presenter = movieDetailPresenter
        return movieDetailVC
    }
}
