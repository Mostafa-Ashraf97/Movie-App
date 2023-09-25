//
//  ViewController.swift
//  Task
//
//  Created by A on 07/08/2023.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    var presenter: MovieListPresenter?
    var router: MovieListVCRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        
        setupTableView()
        presenter?.fetchData()
    }
    
    private func setupTableView() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
}

extension MovieListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.returnMoviesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return UITableViewCell()}
        let model = presenter?.movieModel(for: indexPath)
        cell.configure(text: model?.name ?? ""
                       , image: model!.imageURL) // force
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.willDisplayAt(row: indexPath.row)
    }
    
}

extension MovieListViewController: MovieView {
    func fetchDataSuccess() {
        self.movieTableView.reloadData()
    }
    
    func fetchDataFailed(error: String) {
        print(error)
    }
    
}
