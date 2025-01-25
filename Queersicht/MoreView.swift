//
//  MoreView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 13.07.2024.
//

import SwiftUI

struct MoreView: View {
    var viewModel: ProgramListViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: FavoritesView(viewModel: viewModel)) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color("pastelGreen"))
                            .clipShape(Circle())
                        Text("Favorites")
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding()
                    .background(Color("pastelGreen").opacity(0.2))
                    .cornerRadius(10)
                }
                
                NavigationLink(destination: CorrectionsView()) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color("pastelGreen"))
                            .clipShape(Circle())
                        Text("Corrections")
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding()
                    .background(Color("pastelGreen").opacity(0.2))
                    .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .navigationTitle("More")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
