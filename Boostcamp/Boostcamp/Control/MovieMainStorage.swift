class MovieMainStorage {
    
    private var movies: [MovieMainM] = []
    
    init() { }
    
    init(movies: [MovieMainM]) {
        self.movies = movies
    }
    
    func numberOfMovie() -> Int {
        return movies.count
    }
    
    func movie(at index: Int) -> MovieMainM {
        return movies[index]
    }
    
}
