//
//  Article.swift
//  NewsApp
//
//  Created by Khairul Islam on 10/23/18.
//  Copyright © 2018 Khairul Islam. All rights reserved.
//

import UIKit

struct Article
{
    let source:Source
    let author:String
    let title:String
    let newsUrl:String
    let urlToImage:String
    let publishedAt:String
    let content:String
}

extension Article
{
    init?(jsonDictionary:JSONdictionary) {
        guard
            let source = jsonDictionary["source"] as? JSONdictionary,
            let author = jsonDictionary["author"] as? String,
            let title = jsonDictionary["title"] as? String,
            let newsUrl = jsonDictionary["url"] as? String,
            let urltoImage = jsonDictionary["urlToImage"] as? String,
            let publishedAt = jsonDictionary["publishedAt"] as? String,
            let content = jsonDictionary["content"] as? String else { return nil }
        
        self.source = Source(dictionary: source)!
        self.author = author
        self.title = title
        self.newsUrl = newsUrl
        self.urlToImage = urltoImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

extension Article
{
    static let all = Resource<[Article]>(url: URL(string: url)!, parseJSON: { json in
        guard let dictionary = json as? JSONdictionary,
            let articles = dictionary["articles"] as? [JSONdictionary]
            else { return nil }
        return articles.compactMap(Article.init)
    })
    
}

extension Article
{
    func configure(cell:ArticleTableViewCell)
    {
        cell.albumNameLabel.text = title
        cell.albumGenreLabel.text = content
    }
}

extension Article
{
    var cellDescriptor:CellDescriptor{
        return CellDescriptor.init(reuseIdentifier:"articleCell", nibName:"AlbumTableViewCell", configure:self.configure)
    }
}
