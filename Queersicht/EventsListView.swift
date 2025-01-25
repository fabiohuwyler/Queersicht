//
//  EventsListView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//
import SwiftUI

struct EventsListView: View {
    @ObservedObject var viewModel: ProgramListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.events) { event in
                NavigationLink(destination: EventDetailView(event: event, viewModel: viewModel)) {
                    HStack(alignment: .top, spacing: 10) {
                        if let imageUrl = URL(string: event.imageURL) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipped()
                            } placeholder: {
                                Color.pastelYellow
                                    .frame(width: 100, height: 100)
                            }
                        } else {
                            Color.pastelYellow
                                .frame(width: 100, height: 100)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(event.title)
                                .font(.globerBlack(size: 20))
                                .foregroundColor(.black)
                            Text(event.description.stripHTML())
                                .font(.favoritStdRegular(size: 14))
                                .foregroundColor(.black)
                                .lineLimit(3)
                        }
                    }
                    .padding(.vertical, 10)
                }
                .listRowBackground(Color.pastelYellow)
            }
            .listStyle(PlainListStyle())
            .background(Color.pastelYellow)
            .navigationTitle("Events")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
