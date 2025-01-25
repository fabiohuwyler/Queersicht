//
//  MovieDetailView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//

import SwiftUI
import AVKit

struct MovieDetailView: View {
    var movie: Movie
    @ObservedObject var viewModel: ProgramListViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) { // Changed to .topTrailing to align the star icon to the top right corner
                    GeometryReader { geometry in
                        if let imageUrl = URL(string: movie.imageURL) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: 300)
                                    .clipped()
                            } placeholder: {
                                Color("pastelBlue")
                                    .frame(width: geometry.size.width, height: 300)
                            }
                        } else {
                            Color("pastelBlue")
                                .frame(width: geometry.size.width, height: 300)
                        }
                    }
                    .frame(height: 300)
                    
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color("pastelPink")]), startPoint: .center, endPoint: .bottom)
                        .frame(height: 300)

                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.toggleFavorite(item: ProgramItem(movie: movie, showingDate: Date()))
                        }) {
                            Image(systemName: viewModel.isFavorite(item: ProgramItem(movie: movie, showingDate: Date())) ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(viewModel.isFavorite(item: ProgramItem(movie: movie, showingDate: Date())) ? .yellow : .white)
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                    }
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(movie.title)
                            .font(.globerBlack(size: 34))
                            .bold()
                            .foregroundColor(.black)
                            .padding(.bottom, 16)
                            .padding(.horizontal)
                    }
                }
                .frame(height: 300)

                VStack(alignment: .leading, spacing: 10) {
                    if let originlang = movie.originlang, !originlang.isEmpty {
                        Text(originlang)
                            .font(.favoritStdRegular(size: 16))
                    }

                    if let director = movie.director {
                        Text(director)
                            .font(.favoritStdRegular(size: 16))
                    }

                    Text("\(movie.duration) minutes")
                        .font(.favoritStdRegular(size: 16))

                    if let contentnoteIDs = movie.contentnotes, !contentnoteIDs.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(contentnoteIDs, id: \.self) { id in
                                    if let contentNote = viewModel.getContentNoteByID(id) {
                                        Text(contentNote.title)
                                            .padding(.vertical, 5)
                                            .font(.favoritStdRegular(size: 16))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 10)
                                            .background(Color("pastelPinkCN"))
                                            .cornerRadius(5)
                                    }
                                }
                            }
                        }
                    }

                    Divider()
                        .padding(.vertical, 10)

                    if let attributedDescription = htmlToAttributedString(html: movie.description) {
                        Text(AttributedString(attributedDescription))
                            .padding(.top)
                    } else {
                        Text(movie.description)
                            .padding(.top)
                            .font(.favoritStdRegular(size: 16))
                    }

                    if let trailerURL = movie.trailerURL, !trailerURL.isEmpty {
                        if let url = URL(string: trailerURL), ["youtube.com", "vimeo.com"].contains(url.host ?? "") {
                            VideoPlayer(player: AVPlayer(url: url))
                                .frame(height: 200)
                                .padding(.vertical, 10)
                        } else {
                            Link("Watch Trailer", destination: URL(string: trailerURL)!)
                                .padding(.vertical, 5)
                                .font(.favoritStdRegular(size: 16))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .background(Color.black)
                                .cornerRadius(5)
                        }
                    }

                    Text("Showings")
                        .font(.globerBlack(size: 20))
                        .bold()
                        .padding(.top, 20)

                    ForEach(movie.showings, id: \.id) { showing in
                        VStack(alignment: .leading) {
                            Divider()
                            HStack {
                                Text(showing.date, style: .date)
                                    .font(.globerBlack(size: 16))
                                Text(showing.date, style: .time)
                                    .font(.globerBlack(size: 16))
                            }
                            if let location = viewModel.getLocationByID(showing.locationID) {
                                Text(location.name)
                                    .font(.globerBlack(size: 16))
                                Text(location.address)
                                    .font(.favoritStdRegular(size: 14))
                            } else {
                                Text("Location ID: \(showing.locationID)")
                                    .font(.favoritStdRegular(size: 14))
                            }
                            if let weblink = showing.weblink, !weblink.isEmpty {
                                Link("Buy Ticket", destination: URL(string: weblink)!)
                                    .padding(.vertical, 5)
                                    .font(.favoritStdRegular(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .background(Color.black)
                                    .cornerRadius(5)
                            }
                            if let location = viewModel.getLocationByID(showing.locationID) {
                                NavigationLink(destination: LocationDetailView(location: location, viewModel: viewModel)) {
                                    Text("Location Details")
                                        .padding(.vertical, 5)
                                        .font(.favoritStdRegular(size: 16))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 10)
                                        .background(Color.black)
                                        .cornerRadius(5)
                                }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .background(Color("pastelPink"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func htmlToAttributedString(html: String) -> NSAttributedString? {
        guard let data = html.data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
        let fullRange = NSRange(location: 0, length: attributedString?.length ?? 0)
        
        attributedString?.enumerateAttributes(in: fullRange, options: []) { attributes, range, _ in
            if let font = attributes[.font] as? UIFont {
                let newFont: UIFont
                if font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                    newFont = UIFont.boldSystemFont(ofSize: 16)
                } else {
                    newFont = UIFont.systemFont(ofSize: 16)
                }
                attributedString?.addAttribute(.font, value: newFont, range: range)
            }
        }

        return attributedString
    }
}
