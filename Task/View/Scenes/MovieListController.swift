//
//  ViewController.swift
//  Task
//
//  Created by A on 07/08/2023.
//

import UIKit

class MovieListController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    var presenter : MovieListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter = MovieListPresenter(self)
        presenter.movieViewDidLoad()
    }
    
    func setupTableView() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
}

extension MovieListController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.returnMoviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return UITableViewCell()}
        let model = presenter.movieModel(for: indexPath)
        cell.configure(text: model.name, image: URL(string: "https://image.tmdb.org/t/p/w500/\(model.imageURL)")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "main") as? MovieDetailViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

extension MovieListController : MovieView {
    func fetchDataSuccess() {
        self.movieTableView.reloadData()
    }
    
    func fetchDataFailed(error: String) {
        print(error)
    }
    
}
