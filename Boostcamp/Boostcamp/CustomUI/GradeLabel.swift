import UIKit

class GradeLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10.0
        self.textColor = .white
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(at grade: Int) {
        switch grade {
        case 0:
            self.text = "전"
            self.backgroundColor = .green
        case 12:
            self.text = "12"
            self.backgroundColor = .blue
        case 15:
            self.text = "15"
            self.backgroundColor = .yellow
        case 19:
            self.text = "19"
            self.backgroundColor = .red
        default:
            break
        }
    }
    
}

