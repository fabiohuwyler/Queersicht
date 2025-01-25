//
//  LocationDetailView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 13.07.2024.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    var location: Location
    @ObservedObject var viewModel: ProgramListViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let imageUrl = URL(string: location.imageURL ?? "") {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    } placeholder: {
                        Color.gray
                            .frame(height: 200)
                    }
                } else {
                    Color.gray
                        .frame(height: 200)
                }

                Text(location.name)
                    .font(.globerBlack(size: 34))
                    .foregroundColor(.black)
                    .padding(.top, 16)
                    .padding(.horizontal)

                Text(location.address)
                    .font(.favoritStdRegular(size: 16))
                    .foregroundColor(.black)
                    .padding(.horizontal)

                Text(location.description)
                    .font(.favoritStdRegular(size: 16))
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.top, 10)

                if !location.accessibilityInfo.isEmpty {
                    Text("Accessibility Information")
                        .font(.globerBlack(size: 20))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    Text(location.accessibilityInfo)
                        .font(.favoritStdRegular(size: 16))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                }

                MapView(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 10)

                Button(action: openInMaps) {
                    HStack {
                        Image(systemName: "map")
                        Text("Open in Maps")
                            .font(.favoritStdRegular(size: 16))
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .padding(.top, 10)
            }
            .padding(.bottom)
        }
        .background(Color("pastelGreen"))
        .navigationBarTitle("Location", displayMode: .inline)
    }

    private func openInMaps() {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // More zoomed in
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Location"
        view.addAnnotation(annotation)
    }
}
