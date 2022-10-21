//
//  Movie.swift
//  Netflix Clone
//
//  Created by boss1234 on 29/09/2022.
//

import Foundation

struct TrendingTitleResponse :Codable{
    let results :[Title]
}

struct Title : Codable{ 
//    let adult:Int
//    let backdrop_path :String
//    let genre_ids:[Int]
    
    let id :Int
    let media_type:String?
    let original_language:String?
    let original_title :String?
    let overview:String?
    let poster_path:String?
    let release_date:String?
    let title :String?
    let vote_average:Double
    let vote_count:Int
}
