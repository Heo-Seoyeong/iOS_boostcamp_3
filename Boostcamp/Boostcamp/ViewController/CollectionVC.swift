import UIKit

class CollectionVC: UIViewController {

    var collection: UICollectionView!

    var refreshControl: UIRefreshControl?
    var movieStorage = MovieMainStorage()
    
    private let movieCellIdentifier = "MovieMainCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.collection = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionLayout())
        self.view.addSubview(self.collection)
        
        self.collection.translatesAutoresizingMaskIntoConstraints = false
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.backgroundColor = .white
        self.collection.register(MovieMainCollectionCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        
        self.setRefreshControl()
        self.setupLayout()
        
        self.receiveMovies()
    }
    
    func setupLayout() {
        self.collection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.collection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.collection.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    func collectionLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 12.0, right: 16.0)
        layout.minimumInteritemSpacing = 16.0
        layout.minimumLineSpacing = 32.0
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 50.0, height: 50.0)
        return layout
    }

}

extension CollectionVC {
    
    func setRefreshControl() {
        if self.refreshControl == nil {
            self.refreshControl = UIRefreshControl()
            self.refreshControl!.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
            self.collection.addSubview(self.refreshControl!)
        }
    }
    
    @objc func pullToRefresh() {
        if let refreshControl = self.refreshControl {
            refreshControl.beginRefreshing()
        }
        self.receiveMovies()
    }
    
}

extension CollectionVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieStorage.numberOfMovie()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width/2-24.0
        let size = CGSize(width: width, height: width*1.4 + 80.0)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath)
        if let cell = cell as? MovieMainCollectionCell {
            let movie = self.movieStorage.movie(at: indexPath.row)
            cell.set(by: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = DetailVC()
        nextVC.movieId = self.movieStorage.movie(at: indexPath.row).id
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

extension CollectionVC {
    
    func receiveMovies(by orderType: OrderType = .advanceRate) {
        ServerConnect.connect(path: "/movies" + "?order_type=\(orderType.rawValue)") { (data, response, err) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(MoviesBase.self, from: data)
                self.movieStorage = MovieMainStorage(movies: json.movies ?? [])
                DispatchQueue.main.async {
                    self.collection.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }
    }
    
}
