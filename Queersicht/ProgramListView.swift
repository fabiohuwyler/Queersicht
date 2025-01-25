//
//  ProgramListView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//

import SwiftUI

struct ProgramListView: View {
    @ObservedObject var viewModel: ProgramListViewModel
    @State private var expandedDates: Set<Date> = []

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Image("qustart2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding(.bottom, 10)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("LGBTIAQ*-Filmfestival")
                        .font(.globerBlack(size: 24))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 10)
                    
                    Divider()
                        .background(Color.black)
                        .padding(.horizontal)
                    
                    if !viewModel.favoriteItems.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Favorites")
                                .font(.globerBlack(size: 24))
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(viewModel.favoriteItems) { item in
                                        ProgramItemView(item: item, viewModel: viewModel)
                                            .frame(width: 150, height: 200)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        Divider()
                            .background(Color.black)
                            .padding(.horizontal)
                    }

                    ForEach(viewModel.groupedProgramItems().keys.sorted(), id: \.self) { date in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(dateFormatter.string(from: date))
                                    .font(.globerBlack(size: 24))
                                    .bold()
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        toggleDateExpansion(date)
                                    }
                                Spacer()
                                Image(systemName: expandedDates.contains(date) ? "chevron.up" : "chevron.down")
                                    .padding(.trailing)
                                    .onTapGesture {
                                        toggleDateExpansion(date)
                                    }
                            }

                            if expandedDates.contains(date) {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(viewModel.groupedProgramItems()[date] ?? []) { item in
                                            ProgramItemView(item: item, viewModel: viewModel)
                                                .frame(width: 150, height: 200)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    
                    Divider()
                        .background(Color.black)
                        .padding(.horizontal)
                    
                    Text("Sponsors")
                        .font(.globerBlack(size: 24))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 10)
                    
                    Image("sponsors1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 20)
                }
                .padding(.top)
            }
            .background(Color("pastelOrange").edgesIgnoringSafeArea(.all))
            .navigationTitle("Program")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchData() // Reload the data including favorites
                openFirstAccordion()
            }
        }
    }

    private func toggleDateExpansion(_ date: Date) {
        if expandedDates.contains(date) {
            expandedDates.remove(date)
        } else {
            expandedDates.insert(date)
        }
    }
    
    private func openFirstAccordion() {
        if let firstDate = viewModel.groupedProgramItems().keys.sorted().first {
            expandedDates.insert(firstDate)
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }
}
