import UIKit

class DetailVC: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var movieId: String?

    var refreshControl: UIRefreshControl?
    var commentStorage = CommentStorage()

    private let commentCellIdentifier = "CommentCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CommentCell.self, forCellReuseIdentifier: commentCellIdentifier)
        
        self.setRefreshControl()
        self.setupLayout()
        
        self.receiveMovieDetail()
        self.receiveComments()
    }
    
    func setupLayout() {
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }

    func set(by movie: MovieDetailM) {
        self.title = movie.title
    }
    
}

extension DetailVC {
    
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
        self.receiveComments()
    }
    
}

extension DetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentStorage.numberOfComment()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath)
        if let cell = cell as? CommentCell {
            let comment = self.commentStorage.comment(at: indexPath.row)
            cell.set(by: comment)
        }
        return cell
    }
    
}

extension DetailVC {
    
    func receiveMovieDetail() {
        guard let movieId = movieId else { return }
        ServerConnect.connect(path: "/comments" + "?id=\(movieId)") { (data, response, err) in
            guard let data = data else { return }
            do {
                let movie = try JSONDecoder().decode(MovieDetailM.self, from: data)
                self.set(by: movie)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }
    }

    func receiveComments() {
        guard let movieId = movieId else { return }
        ServerConnect.connect(path: "/comments" + "?movie_id=\(movieId)") { (data, response, err) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(CommentBase.self, from: data)
                self.commentStorage = CommentStorage(comments: json.comments ?? [])
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
