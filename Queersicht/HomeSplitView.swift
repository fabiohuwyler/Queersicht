//
//  HomeSplitView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 18.07.2024.
//

import SwiftUI

struct HomeSplitView: View {
    var body: some View {
        NavigationSplitView {
            ProgramListView(viewModel: ProgramListViewModel())
        } detail: {
            Text("Select an item")
                .font(.largeTitle)
                .foregroundColor(.gray)
        }
    }
}
