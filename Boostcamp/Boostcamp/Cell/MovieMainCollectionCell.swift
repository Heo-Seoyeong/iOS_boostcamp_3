import UIKit

class MovieMainCollectionCell: UICollectionViewCell {
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    let gradeLabel: GradeLabel = {
        let label = GradeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.clipsToBounds = true
        label.layer.cornerRadius = 15.0
        return label
    }()

    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubviews()
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(by movie: MovieMainM) {
        if let thumb = movie.thumb, let url = URL(string: thumb) {
            ImageService.getImage(by: url) { (image) in
                self.posterImageView.image = image
            }
        }
        self.titleLabel.text = movie.title
        self.gradeLabel.set(at: movie.grade ?? 99)
        self.infoLabel.text = "\(movie.reservationGrade ?? 0)위(\(movie.userRating ?? 0)) / \(movie.reservationRate ?? 0)%"
        self.dateLabel.text = movie.date
    }
    
}

extension MovieMainCollectionCell {
    
    func addSubviews()  {
        self.addSubview(posterImageView)
        self.addSubview(titleLabel)
        self.addSubview(gradeLabel)
        self.addSubview(infoLabel)
        self.addSubview(dateLabel)
    }
    
}

extension MovieMainCollectionCell {
    
    func setupLayout() {
        let imageWidth = UIScreen.main.bounds.width/2-24.0
        self.posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        self.posterImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        self.posterImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        self.posterImageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        self.posterImageView.heightAnchor.constraint(equalToConstant: imageWidth*1.4).isActive = true
        
        self.gradeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        self.gradeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.0).isActive = true
        self.gradeLabel.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.gradeLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true

        self.titleLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 15.0).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true

        self.infoLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15.0).isActive = true
        self.infoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        self.dateLabel.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 15.0).isActive = true
        self.dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    }
    
}
