//
//  Untitled.swift
//  NewsReaderApp
//
//  Created by Akshay Punwatkar on 09/12/24.
//
import Foundation

struct NewsApiResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]
}
