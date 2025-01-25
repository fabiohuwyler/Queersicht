//
//  LocationsListView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 13.07.2024.
//

import SwiftUI

struct LocationsListView: View {
    @ObservedObject var viewModel: ProgramListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.locations) { location in
                NavigationLink(destination: LocationDetailView(location: location, viewModel: viewModel)) {
                    HStack(alignment: .top, spacing: 10) {
                        if let imageUrl = URL(string: location.imageURL ?? "") {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipped()
                            } placeholder: {
                                Color.pastelGreen
                                    .frame(width: 100, height: 100)
                            }
                        } else {
                            Color.pastelGreen
                                .frame(width: 100, height: 100)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(location.name)
                                .font(.globerBlack(size: 20))
                                .foregroundColor(.black)
                            Text(location.address)
                                .font(.favoritStdRegular(size: 14))
                                .foregroundColor(.black)
                                .lineLimit(3)
                        }
                    }
                    .padding(.vertical, 10)
                }
                .listRowBackground(Color.pastelGreen)
            }
            .listStyle(PlainListStyle())
            .background(Color.pastelGreen)
            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
