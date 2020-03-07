//
//  DefaultProductsRepository.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/03/01.
//  Copyright © 2020 inswag. All rights reserved.
//

//import Foundation
//
//final class DefaultProductsRepository {
//    
//    private let dataTransferService: DataTransferService
//    
//    init(dataTransferService: DataTransferService) {
//        self.dataTransferService = dataTransferService
//    }
//}
//
//extension DefaultProductsRepository: MoviesRepository {
//    
//    public func moviesList(query: MovieQuery, page: Int, completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
//        
//        let endpoint = APIEndpoints.movies(query: query.query, page: page)
//        let networkTask = self.dataTransferService.request(with: endpoint, completion: completion)
//        return RepositoryTask(networkTask: networkTask)
//    }
//}
