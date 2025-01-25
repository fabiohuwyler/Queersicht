//
//  LocationViewModel.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class LocationViewModel: ObservableObject {
    @Published var locations = [Location]()

    private var db = Firestore.firestore()

    init() {
        fetchData()
    }

    func fetchData() {
        db.collection("locations").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting locations: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            for document in documents {
                print("Document data: \(document.data())")
            }
            self.locations = documents.compactMap { doc in
                try? doc.data(as: Location.self)
            }
            print("Fetched locations: \(self.locations)")
        }
    }
}
