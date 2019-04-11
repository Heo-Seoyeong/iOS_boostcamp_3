//grade    Int    관람등급 (0: 전체이용가 12: 12세 이용가 15: 15세 이용가 19: 19세 이용가)
//thumb    String    포스터 이미지 섬네일 주소
//reservation_grade    Int    예매순위
//title    String    영화제목
//reservation_rate    Double    예매율
//user_rating    Double    사용자 평점
//date    String    개봉일
//id    String    영화 고유 ID

import Foundation

struct MoviesBase : Codable {

    let movies : [MovieMainM]?
    let orderYype : Int?

    enum CodingKeys: String, CodingKey {
        case movies
        case orderYype = "order_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decodeIfPresent([MovieMainM].self, forKey: .movies)
        orderYype = try values.decodeIfPresent(Int.self, forKey: .orderYype)
    }

}

struct MovieMainM: Codable {

    let date: String?
    let thumb: String?
    let title: String?
    let userRating: Double?
    let id: String?
    let grade: Int?
    let reservationGrade: Int?
    let reservationRate: Double?

    enum CodingKeys: String, CodingKey {
        case date
        case thumb
        case title
        case userRating = "user_rating"
        case id
        case grade
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        userRating = try values.decodeIfPresent(Double.self, forKey: .userRating)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        grade = try values.decodeIfPresent(Int.self, forKey: .grade)
        reservationGrade = try values.decodeIfPresent(Int.self, forKey: .reservationGrade)
        reservationRate = try values.decodeIfPresent(Double.self, forKey: .reservationRate)
    }

}

enum OrderType: Int {
    
    case advanceRate = 0
    case cration
    case releaseDate

}
