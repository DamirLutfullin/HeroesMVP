//
//  NetworkManager.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 16.10.2020.
//

import Foundation

protocol NetworkManagerProtocol {
    func getHeroes(completion: @escaping (Result<[Hero]?, Error>) -> ())
    func downloadImage(urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
    func downloadImage2(urlString: String, indexPath: IndexPath, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask?
}

class NetworkManager: NetworkManagerProtocol {
    
    func getHeroes(completion: @escaping (Result<[Hero]?, Error>) -> ()) {
        guard let url = URL(string: "https://akabab.github.io/superhero-api/api/all.json") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data  else { return }
            do {
                let heroes = try JSONDecoder().decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(heroes))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func downloadImage(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(error!)) }
                return
            }
            DispatchQueue.main.async { completion(.success(data)) }
        }
        task.resume()
    }
    
    func downloadImage2(urlString: String, indexPath: IndexPath, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask? {
        guard let url = URL(string: urlString) else { return nil }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(error!)) }
                return
            }
            DispatchQueue.main.async { completion(.success(data)) }
        }
        task.resume()
        return task
    }
}
