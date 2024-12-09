//
//  BookmarkedArticlesView.swift
//  NewsReaderApp
//
//  Created by Akshay Punwatkar on 09/12/24.
//
import SwiftUI

struct BookmarksView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.bookmarkedArticles) { article in
                NavigationLink(destination: NewsDetailView(article: article, viewModel: viewModel)) {
                    HStack {
                        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(article.title)
                                .font(.headline)
                            Text(article.description ?? "")
                                .font(.subheadline)
                                .lineLimit(2)
                        }
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.removeBookmark(article)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Bookmarks")
        }
    }
}
