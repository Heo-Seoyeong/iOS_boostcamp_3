//
//audience    Int    총 관람객수
//actor    String    배우진
//duration    Int    영화 상영 길이
//director    String    감독
//synopsis    String    줄거리
//genre    String    영화 장르
//grade    Int    관람등급 (0: 전체이용가 12: 12세 이용가 15: 15세 이용가 19: 19세 이용가)
//image    String    포스터 이미지 주소
//reservation_grade    Int    예매순위
//title    String    영화제목
//reservation_rate    Double    예매율
//user_rating    Double    사용자 평점
//date    String    개봉일
//id    String    영화 고유 ID

import Foundation

struct MovieDetailM: Codable {

    let synopsis: String?
    let actor: String?
    let director: String?
    let genre: String?
    let date: String?
    let audience: Int?
    let title: String?
    let userRating: Double?
    let id: String?
    let duration: Int?
    let grade: Int?
    let image: String?
    let reservationGrade: Int?
    let reservationRate: Double?
    
    enum CodingKeys: String, CodingKey {
        case synopsis
        case actor
        case director
        case genre
        case date
        case audience
        case title
        case userRating = "user_rating"
        case id
        case duration
        case grade
        case image
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        synopsis = try values.decodeIfPresent(String.self, forKey: .synopsis)
        actor = try values.decodeIfPresent(String.self, forKey: .actor)
        director = try values.decodeIfPresent(String.self, forKey: .director)
        genre = try values.decodeIfPresent(String.self, forKey: .genre)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        audience = try values.decodeIfPresent(Int.self, forKey: .audience)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        userRating = try values.decodeIfPresent(Double.self, forKey: .userRating)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        grade = try values.decodeIfPresent(Int.self, forKey: .grade)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        reservationGrade = try values.decodeIfPresent(Int.self, forKey: .reservationGrade)
        reservationRate = try values.decodeIfPresent(Double.self, forKey: .reservationRate)
    }
    
}
