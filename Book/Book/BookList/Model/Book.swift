//
//  Book.swift
//  Book
//
//  Created by Hanriver Macbook on 08/06/24.
//

import Foundation


struct Book: Decodable, Hashable {
    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String?
}
