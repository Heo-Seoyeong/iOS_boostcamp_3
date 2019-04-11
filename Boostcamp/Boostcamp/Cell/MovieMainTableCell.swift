import UIKit

class MovieMainTableCell: UITableViewCell {
    
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
        return label
    }()
    
    let userRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    let reservationGradeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    let reservationRateLabel: UILabel = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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
        self.userRatingLabel.text = "평정 : \(movie.userRating ?? 0)"
        self.reservationGradeLabel.text = "예매순위 : \(movie.reservationGrade ?? 0)"
        self.reservationRateLabel.text = "예매율 : \(movie.reservationRate ?? 0)"
        self.dateLabel.text = movie.date
    }

}

extension MovieMainTableCell {

    func addSubviews()  {
        self.contentView.addSubview(posterImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(gradeLabel)
        self.contentView.addSubview(userRatingLabel)
        self.contentView.addSubview(reservationGradeLabel)
        self.contentView.addSubview(reservationRateLabel)
        self.contentView.addSubview(dateLabel)
    }

}

extension MovieMainTableCell {
    
    func setupLayout() {
//        100/140
        self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0).isActive = true
        self.posterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8.0).isActive = true
        self.posterImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8.0).isActive = true
        self.posterImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        self.posterImageView.heightAnchor.constraint(equalToConstant: 112.0).isActive = true

        self.titleLabel.bottomAnchor.constraint(equalTo: self.userRatingLabel.topAnchor, constant: -8.0).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.posterImageView.rightAnchor, constant: 8.0).isActive = true

        self.gradeLabel.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor, constant: 0).isActive = true
        self.gradeLabel.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 8.0).isActive = true
        self.gradeLabel.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        self.gradeLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        self.userRatingLabel.centerYAnchor.constraint(equalTo: self.posterImageView.centerYAnchor, constant: 0).isActive = true
        self.userRatingLabel.leftAnchor.constraint(equalTo: self.posterImageView.rightAnchor, constant: 8.0).isActive = true

        self.reservationGradeLabel.centerYAnchor.constraint(equalTo: self.posterImageView.centerYAnchor, constant: 0).isActive = true
        self.reservationGradeLabel.leftAnchor.constraint(equalTo: self.userRatingLabel.rightAnchor, constant: 8.0).isActive = true

        self.reservationRateLabel.centerYAnchor.constraint(equalTo: self.posterImageView.centerYAnchor, constant: 0).isActive = true
        self.reservationRateLabel.leftAnchor.constraint(equalTo: self.reservationGradeLabel.rightAnchor, constant: 8.0).isActive = true
        
        self.dateLabel.topAnchor.constraint(equalTo: self.userRatingLabel.bottomAnchor, constant: 8.0).isActive = true
        self.dateLabel.leftAnchor.constraint(equalTo: self.posterImageView.rightAnchor, constant: 8.0).isActive = true
    }

}
