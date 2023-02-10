//
//  ImageCache.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import Foundation

enum ImageCacheError: Error {
    case invalidDataType
    case failedInsert
}

protocol ImageCache {
    func get(for url: URL) -> AnyObject?
    
    func insert(to url: URL, data: AnyObject) throws
}
