//
//  QueersichtApp.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//

import SwiftUI
import Firebase

@main
struct QueersichtApp: App {
    init() {
        FirebaseApp.configure()
        setupAppearance()
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                ProgramListView(viewModel: ProgramListViewModel())
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                MoviesListView(viewModel: ProgramListViewModel())
                    .tabItem {
                        Label("Movies", systemImage: "film")
                    }
                EventsListView(viewModel: ProgramListViewModel())
                    .tabItem {
                        Label("Events", systemImage: "calendar")
                    }
                LocationsListView(viewModel: ProgramListViewModel())
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

    private func setupAppearance() {
        // Tab Bar Appearance
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = .black
        tabAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "pastelGreen")
        tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "pastelGreen")!]
        tabAppearance.stackedLayoutAppearance.normal.iconColor = .white
        tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]

        UITabBar.appearance().standardAppearance = tabAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        }

        // Navigation Bar Appearance
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = .black
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "pastelGreen")!, .font: UIFont(name: "Glober Black", size: 20)!]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "pastelGreen")!, .font: UIFont(name: "Glober Black", size: 34)!]

        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance

        // Set status bar style
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let statusBarFrame = windowScene.statusBarManager?.statusBarFrame
            let statusBarView = UIView(frame: statusBarFrame ?? CGRect.zero)
            statusBarView.backgroundColor = .black
            windowScene.windows.first?.addSubview(statusBarView)
        }
        
        UINavigationBar.appearance().tintColor = UIColor(named: "pastelGreen")
    }
}
