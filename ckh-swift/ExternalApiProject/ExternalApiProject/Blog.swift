//
//  Blog.swift
//  ExternalApiProject
//
//  Created by NEXTAcademy on 11/23/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import Foundation
import SwiftyJSON

class Blog{
    
    static var all = [Blog]()
    
    var id : Int?
    var title : String
    var body : String
    
    init(json : JSON){
        self.title = json["title"].string ?? "No Title"
        self.body = json["body"].string ?? "NO Content"
        self.id = json["id"].int
    }
    
    
    
}
