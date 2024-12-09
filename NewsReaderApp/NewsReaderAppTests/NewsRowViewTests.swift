//
//  NewsRowViewTests.swift
//  NewsReaderApp
//
//  Created by Akshay Punwatkar on 10/12/24.
//
import XCTest
import Combine
@testable import NewsReaderApp


class NewsRowViewTests: XCTestCase {
    func testBookmarkButtonState() {
        let article = NewsArticle(
            title: "Test Article",
            description: "Description",
            content: "Content",
            url: "https://test.com",
            urlToImage: "https://test.com/image.jpg",
            publishedAt: "2024-12-09",
            source: NewsArticle.Source(id: "1", name: "Test Source")
        )
        
        let viewModel = NewsViewModel()
        let rowView = NewsRowView(article: article)
      
    }
}
