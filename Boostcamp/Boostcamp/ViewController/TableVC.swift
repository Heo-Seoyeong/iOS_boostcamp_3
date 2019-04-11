import UIKit

class TableVC: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var refreshControl: UIRefreshControl?
    var movieStorage = MovieMainStorage()

    private let movieCellIdentifier = "MovieMainTableCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieMainTableCell.self, forCellReuseIdentifier: movieCellIdentifier)

        self.setRefreshControl()
        self.setupLayout()

        self.receiveMovies()
    }

    func setupLayout() {
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }

}

extension TableVC {

    func setRefreshControl() {
        if self.refreshControl == nil {
            self.refreshControl = UIRefreshControl()
            self.refreshControl!.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
            self.tableView.addSubview(self.refreshControl!)
        }
    }

    @objc func pullToRefresh() {
        if let refreshControl = self.refreshControl {
            refreshControl.beginRefreshing()
        }
        self.receiveMovies()
    }

}

extension TableVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieStorage.numberOfMovie()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath)
        if let cell = cell as? MovieMainTableCell {
            let movie = self.movieStorage.movie(at: indexPath.row)
            cell.set(by: movie)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailVC()
        nextVC.movieId = self.movieStorage.movie(at: indexPath.row).id
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

extension TableVC {

    func receiveMovies(by orderType: OrderType = .advanceRate) {
        ServerConnect.connect(path: "/movies" + "?order_type=\(orderType.rawValue)") { (data, response, err) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(MoviesBase.self, from: data)
                self.movieStorage = MovieMainStorage(movies: json.movies ?? [])
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }
    }

}
