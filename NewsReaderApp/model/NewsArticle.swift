//
//  Article.swift
//  NewsReaderApp
//
//  Created by Akshay Punwatkar on 04/12/24.
//
import Foundation


struct NewsArticle: Identifiable, Codable, Equatable {
    var id: String {
        return url 
    }
    
    let title: String
    let description: String?
    let content: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let source: Source

    struct Source: Codable {
        let id: String?
        let name: String
    }
    
    static func ==(lhs: NewsArticle, rhs: NewsArticle) -> Bool {
        return lhs.id == rhs.id
    }
}
