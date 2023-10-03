//
//  MovieListPresenterProtocol.swift
//  Task
//
//  Created by A on 03/10/2023.
//

import Foundation

protocol MovieView : AnyObject {
    var presenter : MovieListPresenter? {get set}
    func fetchDataSuccess()
    func fetchDataFailed(error: String)
}

struct MovieViewItem { 
    var name: String
    var imageURL: URL
}
