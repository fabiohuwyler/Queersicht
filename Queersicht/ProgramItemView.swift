//
//  ProgramItemView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 11.07.2024.
//

import SwiftUI

struct ProgramItemView: View {
    var item: ProgramItem
    @ObservedObject var viewModel: ProgramListViewModel

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            NavigationLink(destination: destinationView(for: item)) {
                ZStack(alignment: .bottomLeading) {
                    GeometryReader { geometry in
                        if let imageUrl = URL(string: item.imageURL) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipped()
                            } placeholder: {
                                Color.gray
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                            }
                        } else {
                            Color.gray
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                    .frame(height: 200)

                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .frame(height: 200)

                    Text(item.title)
                        .font(.favoritStdRegular(size: 16))
                        .foregroundColor(.white)
                        .padding()
                    
                    VStack {
                        HStack {
                            Spacer()
                            Text(item.showingDate, style: .time)
                                .font(.favoritStdRegular(size: 14))
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(5)
                                .padding(10)
                        }
                        Spacer()
                    }
                }
                .frame(width: 150, height: 200)
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    private func destinationView(for item: ProgramItem) -> some View {
        if let movie = item.movie {
            return AnyView(MovieDetailView(movie: movie, viewModel: viewModel))
        } else if let event = item.event {
            return AnyView(EventDetailView(event: event, viewModel: viewModel))
        } else {
            return AnyView(EmptyView())
        }
    }
}
