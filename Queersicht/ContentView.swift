//
//  ContentView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeSplitView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            MoviesSplitView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }

            EventsSplitView()
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }

            LocationsSplitView()
                .tabItem {
                    Label("Locations", systemImage: "map")
                }

            CorrectionsView()
                .tabItem {
                    Label("Corrections", systemImage: "pencil")
                }
        }
    }
}
