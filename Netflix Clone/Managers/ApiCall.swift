//
//  ApiCall.swift
//  Netflix Clone
//
//  Created by boss1234 on 28/09/2022.
//

import Foundation

struct Constants{
    static let api_key = "e6e8b8fcab1cfc394a9cd879974c4bdb"
    static let base_url = "https://api.themoviedb.org"
}
enum ApiError:Error{
    case failedToGetData
}

class ApiCall {
    static let shared = ApiCall()
    
    func getTrendingMovie(completion :@escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_url)/3/trending/movie/day?api_key=\(Constants.api_key)") else{return}
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)){
            data,_,error in
            guard let data = data,error == nil else {
                return
            }
            do{
//                let result = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
//
//                print(result)
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
                
            }catch{
                completion(.failure(ApiError.failedToGetData))
            }

        }
        task.resume()
        
    }
    func  getTrendingTvs(completion :@escaping (Result<[Title],Error>) -> Void ){
        guard let url = URL(string: "\(Constants.base_url)/3/trending/tv/day?api_key=\(Constants.api_key)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)){
            data,_,error in
            guard let data = data,error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()

    }
    func getUpComingMovie(completion:@escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_url)/3/movie/upcoming?api_key=\(Constants.api_key)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)){
            data,_,error in
            guard let data = data,error == nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(ApiError.failedToGetData))

            }

        }
        task.resume()
    }
    
    func getPopularMovie(completion:@escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_url)/3/movie/popular?api_key=\(Constants.api_key)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest.init(url: url)){
            data,_,error in
            guard let data = data,error == nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(ApiError.failedToGetData))
            }

        }
        task.resume()
    }
    func getTopRated(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_url)/3/movie/top_rated?api_key=\(Constants.api_key)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data,_,error in
            guard let data = data,error == nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovie(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_url)/3/discover/movie?api_key=\(Constants.api_key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data,_,error in
            guard let data = data ,error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self,from:data)
                completion(.success(result.results))
            }catch{
                completion(.failure(ApiError.failedToGetData))
            }

        }
        task.resume()
            
    }
    func search(with query:String,completion: @escaping (Result<[Title],Error>) -> Void){
        //https://api.themoviedb.org/3/search/movie?api_key={api_key}&query=Jack+Reacher

        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.base_url)/3/search/movie?api_key=\(Constants.api_key)&query=\(query)") else {return}
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
                data,_,error in
                guard let data = data,error == nil else {
                    return
                }
                do{
                    let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    completion(.success(result.results))
                }catch{
                    completion(.failure(ApiError.failedToGetData))
                }
            }
            task.resume()
    }
}
