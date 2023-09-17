//
//  MovieListVCRouter.swift
//  Task
//
//  Created by A on 24/08/2023.
//

import UIKit

class MovieListVCRouter {
   static func createMovieListVC() -> UIViewController {
//       let navigationController = mainStoryBoard.instantiateViewController(withIdentifier: "UINavigationController")
//       let movieView = navigationController.children.first as? MovieView
       let movieView = MovieListViewController()
       let navigationController = UINavigationController(rootViewController: movieView)

       let movieListVCRouter = MovieListVCRouter()
       let movieListPresenter = MovieListPresenter(view: movieView, router: movieListVCRouter)
       movieView.presenter = movieListPresenter
        return navigationController
    }
    
    static var mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
     func navigateToMovieDetailVC(movie: Movie, view: MovieView?) {
        let movieDetailView = MovieDetailVCRouter.createMovieDetailVC(movie: movie)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(movieDetailView, animated: true)
        }
    }
}
