//
//  NewsDetailView.swift
//  NewsReaderApp
//
//  Created by Akshay Punwatkar on 09/12/24.
//
import SwiftUI

struct NewsDetailView: View {
    let article: NewsArticle
    @ObservedObject var viewModel: NewsViewModel 
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ScrollView {
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
            Text(article.title)
                .font(.title)
                .padding()
            Text(article.description ?? "")
                .padding()
            Link("Read More", destination: URL(string: article.url)!)
        }
        .navigationTitle(article.title)
        .overlay(
            HStack {
                Spacer()
                Button(action: {
                    toggleBookmark(article)  // Handle bookmark action
                }) {
                    Image(systemName: "star.fill")
                        .foregroundColor(viewModel.bookmarkedArticles.contains(article) ? .yellow : .gray)
                }
                .padding()
            }
            , alignment: .topTrailing
        )
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Bookmark Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }

        Button(action: {
            toggleBookmark(article)
        }) {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(viewModel.bookmarkedArticles.contains(article) ? .yellow : .gray)
                Text(viewModel.bookmarkedArticles.contains(article) ? "Remove Bookmark" : "Add Bookmark")
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 5)
        }
        .padding()
    }

    func toggleBookmark(_ article: NewsArticle) {
        if viewModel.bookmarkedArticles.contains(article) {
            viewModel.removeBookmark(article)
            alertMessage = "Bookmark removed."
        } else {
            viewModel.bookmarkArticle(article)
            alertMessage = "Bookmark added."
        }
        showAlert = true
    }
}
