//
//  MovieDetailVCRouter.swift
//  Task
//
//  Created by A on 24/08/2023.
//

import UIKit

class MovieDetailVCRouter {
    
    static func createMovieDetailVC(movie: Movie) -> UIViewController {
        
//        let movieDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailVC")
        let movieDetailVC = MovieDetailViewController()
        if let movieDetailView = movieDetailVC as? MovieDetailView {  // leh always succeeds
            let movieDetailPresenter = MovieDetailPresenter(view: movieDetailView, movie: movie)
            movieDetailView.presenter = movieDetailPresenter
        }
        
        return movieDetailVC
        
    }
    
//    static var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
}
