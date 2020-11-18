//
//  Model.swift
//  NEWS
//
//  Created by Nguyen Trung on 15/11/2020.
//  Copyright © 2020 Nguyen Hung. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResultAPIModel {
    var articles: [Article]?
    var status: String?
    var totalResults: Int?
    
    required public init?(json: JSON) {
        status = json["status"].stringValue
        totalResults = json["totalResults"].intValue
        articles = json["articles"].arrayValue.map { Article(json: JSON($0))! }
    }
}

class Article {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    required public init?(json: JSON) {
        source = Source(json: JSON(json["source"]))
        author = json["author"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        url = json["url"].stringValue
        urlToImage = json["urlToImage"].stringValue
        publishedAt = json["publishedAt"].stringValue
        content = json["content"].stringValue
    }
}

class Source {
    var id: String?
    var name: String?
    
    required public init?(json: JSON){
        id = json["id"].stringValue
        name = json["name"].stringValue
    }
        
}
