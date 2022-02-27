//
//  Photo.swift
//  Day50Challenge
//
//  Created by BERAT ALTUNTAŞ on 27.02.2022.
//

import UIKit

class Photo: NSObject, NSCoding {
    var title:String
    var imageUrl:String
    var date:String
    
    init(title:String, imageUrl:String,date:String){
        self.title = title
        self.imageUrl = imageUrl
        self.date = date
    }
    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: "title") as? String ?? ""
        imageUrl = coder.decodeObject(forKey: "imageUrl") as? String ?? ""
        date = coder.decodeObject(forKey: "date") as? String ?? ""
    }
        
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(imageUrl, forKey: "imageUrl")
        coder.encode(date, forKey: "date")
    }
}
