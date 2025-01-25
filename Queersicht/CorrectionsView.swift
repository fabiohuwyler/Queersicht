//
//  CorrectionsView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 13.07.2024.
//

import SwiftUI
import WebKit

struct CorrectionsView: View {
    var body: some View {
        WebView(url: URL(string: "https://www.queersicht.ch/de/programm-de/programmaenderungen-de")!) // Change the URL to the actual corrections URL
            .navigationTitle("Corrections")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
