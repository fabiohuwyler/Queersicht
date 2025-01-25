//
//  ProgramListViewModel.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProgramListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var events: [Event] = []
    @Published var locations: [Location] = []
    @Published var contentNotes: [ContentNote] = [] // Add this line to hold content notes
    @Published var favoriteItems: [ProgramItem] = []

    private var db = Firestore.firestore()

    init() {
        fetchData()
    }

    func fetchData() {
        fetchMovies()
        fetchEvents()
        fetchLocations()
        fetchContentNotes() // Fetch content notes
    }

    private func fetchMovies() {
        db.collection("movies").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No documents in movies collection")
                return
            }
            self.movies = documents.compactMap { doc -> Movie? in
                try? doc.data(as: Movie.self)
            }
        }
    }

    private func fetchEvents() {
        db.collection("events").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No documents in events collection")
                return
            }
            self.events = documents.compactMap { doc -> Event? in
                try? doc.data(as: Event.self)
            }
        }
    }

    private func fetchLocations() {
        db.collection("locations").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No documents in locations collection")
                return
            }
            self.locations = documents.compactMap { doc -> Location? in
                try? doc.data(as: Location.self)
            }
        }
    }

    private func fetchContentNotes() {
        db.collection("contentnotes").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No documents in contentnotes collection")
                return
            }
            self.contentNotes = documents.compactMap { doc -> ContentNote? in
                try? doc.data(as: ContentNote.self)
            }
        }
    }

    func groupedProgramItems() -> [Date: [ProgramItem]] {
        let items = movies.flatMap { movie in
            movie.showings.map { showing in
                ProgramItem(movie: movie, showingDate: showing.date)
            }
        } + events.map { event in
            ProgramItem(event: event, showingDate: event.date)
        }

        return Dictionary(grouping: items, by: { Calendar.current.startOfDay(for: $0.showingDate) })
    }

    func getLocationByID(_ id: String) -> Location? {
        return locations.first { $0.id == id }
    }

    func getContentNoteByID(_ id: String) -> ContentNote? {
        return contentNotes.first { $0.id == id }
    }

    func toggleFavorite(item: ProgramItem) {
        if let index = favoriteItems.firstIndex(where: { $0.id == item.id }) {
            favoriteItems.remove(at: index)
        } else {
            favoriteItems.append(item)
        }
    }

    func isFavorite(item: ProgramItem) -> Bool {
        return favoriteItems.contains(where: { $0.id == item.id })
    }
}
