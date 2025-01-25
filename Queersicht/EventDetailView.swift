//
//  EventDetailView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//

import SwiftUI
import AVKit

struct EventDetailView: View {
    var event: Event
    @ObservedObject var viewModel: ProgramListViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottomLeading) {
                    GeometryReader { geometry in
                        if let imageUrl = URL(string: event.imageURL) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: 300)
                                    .clipped()
                            } placeholder: {
                                Color("pastelYellow")
                                    .frame(width: geometry.size.width, height: 300)
                            }
                        } else {
                            Color("pastelYellow")
                                .frame(width: geometry.size.width, height: 300)
                        }
                    }
                    .frame(height: 300)
                    
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color("pastelYellow")]), startPoint: .center, endPoint: .bottom)
                        .frame(height: 300)

                    Text(event.title)
                        .font(.globerBlack(size: 34))
                        .bold()
                        .foregroundColor(.black)
                        .padding(.bottom, 16)
                        .padding(.horizontal)
                }
                .frame(height: 300)

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(event.date, style: .date)
                            .font(.favoritStdRegular(size: 16))
                        Text(event.date, style: .time)
                            .font(.favoritStdRegular(size: 16))
                    }

                    if let location = viewModel.getLocationByID(event.locationID) {
                        VStack(alignment: .leading) {
                            Text(location.name)
                                .font(.globerBlack(size: 16))
                            Text(location.address)
                                .font(.favoritStdRegular(size: 14))
                        }
                        .padding(.vertical, 10)
                    }

                    Divider()
                        .padding(.vertical, 10)

                    if let attributedDescription = htmlToAttributedString(html: event.description) {
                        Text(AttributedString(attributedDescription))
                            .padding(.top)
                    } else {
                        Text(event.description)
                            .padding(.top)
                            .font(.favoritStdRegular(size: 16))
                    }

                    if let weblink = event.weblink, !weblink.isEmpty {
                        Link("Event Details", destination: URL(string: weblink)!)
                            .padding(.vertical, 5)
                            .font(.favoritStdRegular(size: 16))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .background(Color.black)
                            .cornerRadius(5)
                    }

                    if let location = viewModel.getLocationByID(event.locationID) {
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
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .background(Color("pastelYellow"))
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
