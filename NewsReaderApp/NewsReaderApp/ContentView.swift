//
//  ContentView.swift
//  NewsReaderApp
//
//  Created by Akshay Punwatkar on 04/12/24.
//
import SwiftUI


struct ContentView: View {
    @StateObject var viewModel = NewsViewModel()
    
    var body: some View {
        TabView {
            NewsListView(viewModel: viewModel)
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            BookmarksView(viewModel: viewModel)
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    ContentView()
}
