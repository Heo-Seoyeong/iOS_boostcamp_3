//
//rating    Double    평점
//timestamp    Double    작성일시 UNIX Timestamp 값
//writer    String    작성자
//movie_id    String    영화 고유ID
//contents    String    한줄평 내용

import Foundation

struct CommentBase: Codable {
    let comments: [CommentM]?
    let movieId: String?

    enum CodingKeys: String, CodingKey {
        case comments = "comments"
        case movieId = "movie_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comments = try values.decodeIfPresent([CommentM].self, forKey: .comments)
        movieId = try values.decodeIfPresent(String.self, forKey: .movieId)
    }

}

struct CommentM: Codable {

    let rating: Int?
    let contents: String?
    let id: String?
    let movieId: String?
    let timestamp: Double?
    let writer: String?

    enum CodingKeys: String, CodingKey {
        case rating
        case contents
        case id
        case movieId = "movie_id"
        case timestamp
        case writer
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
        contents = try values.decodeIfPresent(String.self, forKey: .contents)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        movieId = try values.decodeIfPresent(String.self, forKey: .movieId)
        timestamp = try values.decodeIfPresent(Double.self, forKey: .timestamp)
        writer = try values.decodeIfPresent(String.self, forKey: .writer)
    }

}
