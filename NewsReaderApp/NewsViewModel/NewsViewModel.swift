//
//  NewsViewModel.swift
//  NewsReaderApp
//
//  Created by Akshay Punwatkar on 09/12/24.
//
import Foundation
import Combine

public class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    @Published var selectedArticle: NewsArticle?
    @Published var isLoading: Bool = false
    @Published var selectedCategory: String = "general"
    @Published var bookmarkedArticles: [NewsArticle] = []

    private let apiUrl = "https://newsapi.org/v2/top-headlines?"
    private let apiKey = "cb997684783d462c9ada32fdc8e49357"
 

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchNews()
        loadBookmarkedArticles()
    }

    func fetchNews() {
        isLoading = true

        guard let url = URL(string: "\(apiUrl)?country=us&category=\(selectedCategory)&apiKey=\(apiKey)") else {
            isLoading = false
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: NewsApiResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching news: \(error)")
                case .finished:
                    break
                }
                self.isLoading = false
            } receiveValue: { response in
                self.articles = response.articles
            }
            .store(in: &cancellables)
    }

    func selectArticle(_ article: NewsArticle) {
        selectedArticle = article
    }

    func bookmarkArticle(_ article: NewsArticle) {
        if !bookmarkedArticles.contains(article) {
            bookmarkedArticles.append(article)
            saveBookmarkedArticles()
        }
    }

    func removeBookmark(_ article: NewsArticle) {
        if let index = bookmarkedArticles.firstIndex(of: article) {
            bookmarkedArticles.remove(at: index)
            saveBookmarkedArticles()
        }
    }

    private func loadBookmarkedArticles() {
        guard let data = UserDefaults.standard.data(forKey: "bookmarkedArticles") else { return }
        if let decodedData = try? JSONDecoder().decode([NewsArticle].self, from: data) {
            bookmarkedArticles = decodedData
        }
    }

    private func saveBookmarkedArticles() {
        if let encodedData = try? JSONEncoder().encode(bookmarkedArticles) {
            UserDefaults.standard.set(encodedData, forKey: "bookmarkedArticles")
        }
    }
}
