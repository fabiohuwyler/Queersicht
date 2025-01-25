//
//  Models.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Showing: Identifiable, Codable {
    var id: String
    var date: Date
    var locationID: String
    var weblink: String?
    var movieID: String?
    var eventID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case date
        case locationID
        case weblink
        case movieID
        case eventID
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        let timestamp = try container.decode(Timestamp.self, forKey: .date)
        date = timestamp.dateValue()
        locationID = try container.decode(String.self, forKey: .locationID)
        weblink = try container.decodeIfPresent(String.self, forKey: .weblink)
        movieID = try container.decodeIfPresent(String.self, forKey: .movieID)
        eventID = try container.decodeIfPresent(String.self, forKey: .eventID)
    }

    init(id: String = UUID().uuidString, date: Date, locationID: String, weblink: String? = nil, movieID: String? = nil, eventID: String? = nil) {
        self.id = id
        self.date = date
        self.locationID = locationID
        self.weblink = weblink
        self.movieID = movieID
        self.eventID = eventID
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(Timestamp(date: date), forKey: .date)
        try container.encode(locationID, forKey: .locationID)
        try container.encodeIfPresent(weblink, forKey: .weblink)
        try container.encodeIfPresent(movieID, forKey: .movieID)
        try container.encodeIfPresent(eventID, forKey: .eventID)
    }
}

struct Movie: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var duration: Int
    var imageURL: String
    var showings: [Showing]
    var director: String?
    var contentnotes: [String]?
    var originlang: String?
    var trailerURL: String?  // Add this line

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case duration
        case imageURL
        case showings
        case director
        case contentnotes
        case originlang
        case trailerURL  // Add this line
    }
}

struct Event: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var date: Date
    var imageURL: String
    var locationID: String
    var weblink: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case date
        case imageURL
        case locationID
        case weblink
    }
}

struct Location: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var accessibilityInfo: String
    var imageURL: String?
    var description: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case latitude
        case longitude
        case accessibilityInfo
        case imageURL
        case description
    }
}

struct ProgramItem: Identifiable, Codable {
    var id: String { movie?.id ?? event?.id ?? UUID().uuidString }
    var title: String { movie?.title ?? event?.title ?? "" }
    var imageURL: String { movie?.imageURL ?? event?.imageURL ?? "" }
    var showingDate: Date
    var movie: Movie?
    var event: Event?

    init(movie: Movie, showingDate: Date) {
        self.movie = movie
        self.showingDate = showingDate
    }

    init(event: Event, showingDate: Date) {
        self.event = event
        self.showingDate = showingDate
    }
}

struct ContentNote: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}
