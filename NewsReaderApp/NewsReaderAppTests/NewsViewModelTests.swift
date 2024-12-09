//
//  Untitled.swift
//  NewsReaderApp
//
//  Created by Akshay Punwatkar on 10/12/24.
//

import XCTest
import Combine
@testable import NewsReaderApp

class NewsViewModelTests: XCTestCase {
    var viewModel: NewsViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        viewModel = NewsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        cancellables = []
        super.tearDown()
    }

    func testFetchNews() {
        let expectation = self.expectation(description: "News fetched")

        viewModel.fetchNews()

        viewModel.$articles
            .sink { articles in
       
                if !articles.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testBookmarkArticle() {
        let article = NewsArticle(
            title: "Test Article",
            description: "Description",
            content: "Content",
            url: "https://test.com",
            urlToImage: "https://test.com/image.jpg",
            publishedAt: "2024-12-09",
            source: NewsArticle.Source(id: "1", name: "Test Source")
        )

        viewModel.bookmarkArticle(article)
        XCTAssertTrue(viewModel.bookmarkedArticles.contains(article), "Article should be bookmarked")

        viewModel.removeBookmark(article)
        XCTAssertFalse(viewModel.bookmarkedArticles.contains(article), "Article should be removed from bookmarks")
    }
    
    func testBookmarkPersistence() {
        let article = NewsArticle(
            title: "Test Article",
            description: "Description",
            content: "Content",
            url: "https://test.com",
            urlToImage: "https://test.com/image.jpg",
            publishedAt: "2024-12-09",
            source: NewsArticle.Source(id: "1", name: "Test Source")
        )

        viewModel.bookmarkArticle(article)
        
        viewModel.bookmarkedArticles.removeAll()
        
        XCTAssertTrue(viewModel.bookmarkedArticles.contains(article), "Bookmarked article should be loaded from UserDefaults")
    }


}
