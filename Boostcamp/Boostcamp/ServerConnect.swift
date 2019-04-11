import Foundation

class ServerConnect {
    
    class func connect(path: String,
                       completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlString = BASEURL + path
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            completion( data, response, err )
            }.resume()
    }
    
}
