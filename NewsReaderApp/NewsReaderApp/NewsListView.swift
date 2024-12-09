//
//  Untitled.swift
//  NewsReaderApp
//
//  Created by Akshay Punwatkar on 09/12/24.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var categories = ["general", "business", "entertainment", "health", "science", "sports", "technology"]

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Category", selection: $viewModel.selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category.capitalized).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: viewModel.selectedCategory) { _ in
                    viewModel.fetchNews()
                }

                ScrollView {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    } else {
                        VStack(spacing: 15) {
                            ForEach(viewModel.articles) { article in
                                NavigationLink(destination: NewsDetailView(article: article, viewModel: viewModel)) {
                                    NewsRowView(article: article)
                                }
                            }
                        }
                        .padding(.top, 10)
                    }
                }
            }
            .navigationTitle("News")
            .onAppear {
                viewModel.fetchNews()
            }
            .refreshable {
                await viewModel.fetchNews()
            }
        }
    }
}

struct NewsRowView: View {
    let article: NewsArticle

    var body: some View {
        HStack(alignment: .top) {
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150) // Increased image size
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .truncationMode(.tail)
                
                Text(article.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .truncationMode(.tail)
            }
            .padding(.leading, 10)

        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3)),
            alignment: .bottom
        )
    }
}
