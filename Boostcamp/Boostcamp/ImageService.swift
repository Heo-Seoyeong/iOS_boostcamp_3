import UIKit

class ImageService {

    static let cache = NSCache<NSString, UIImage>()
    
    static func downloadImage(by url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            var downloadedImage: UIImage?

            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            if let downloadedImage = downloadedImage {
                cache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
            }

            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }.resume()
    }

    static func getImage(by url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            downloadImage(by: url, completion: completion)
        }
    }

}
