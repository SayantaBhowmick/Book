//
//  BookListViewModel.swift
//  Book
//
//  Created by Hanriver Macbook on 08/06/24.
//

import Foundation

final class BookListViewModel: ObservableObject {
    
    var bookList: [Book] = []
    
    //MARK: - Call Book List API
    func getBookList(page: Int, limit: Int, completion: @escaping (Result<[Book], Error>) -> Void) {
        let url = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=\(limit)")! // note, https, not http

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let jsonData = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            do {
                let decoder = JSONDecoder()
                let books = try decoder.decode([Book].self, from: jsonData)
                if page == 1 {
                    self?.bookList = []
                }
                self?.bookList.append(contentsOf: books)
                completion(.success(books))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

}
