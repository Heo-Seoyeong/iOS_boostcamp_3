import UIKit

class CommentCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "PROFILE")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let writerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()

    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()

    let contentsLabel: UILabel = {
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
    
    func set(by comment: CommentM) {
        self.writerLabel.text = comment.writer
        self.ratingLabel.text = "\(comment.rating ?? 0)"
        self.timeLabel.text = (comment.timestamp ?? 0).dateString()
        self.contentsLabel.text = comment.contents
    }
    
}

extension CommentCell {
    
    func addSubviews()  {
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(writerLabel)
        self.contentView.addSubview(ratingLabel)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(contentsLabel)
    }

    func setupLayout() {
        self.profileImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16.0).isActive = true
        self.profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -16.0).isActive = true
        self.profileImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 30.0).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        self.writerLabel.topAnchor.constraint(equalTo: self.profileImageView.topAnchor, constant: 0.0).isActive = true
        self.writerLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 8.0).isActive = true
        
        self.ratingLabel.centerYAnchor.constraint(equalTo: self.writerLabel.centerYAnchor, constant: 0.0).isActive = true
        self.ratingLabel.leftAnchor.constraint(equalTo: self.writerLabel.rightAnchor, constant: 8.0).isActive = true
        self.ratingLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -30.0).isActive = true
        
        self.timeLabel.topAnchor.constraint(equalTo: self.ratingLabel.bottomAnchor, constant: 8.0).isActive = true
        self.timeLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 8.0).isActive = true
        self.timeLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -30.0).isActive = true
        
        self.contentsLabel.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 8.0).isActive = true
        self.contentsLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 8.0).isActive = true
        self.contentsLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -30.0).isActive = true
    }
    
}
