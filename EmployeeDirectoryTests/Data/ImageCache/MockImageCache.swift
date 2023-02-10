//
//  MockDiskImageCache.swift
//  EmployeeDirectoryTests
//
//  Created by hope on 2/9/23.
//

import Foundation
@testable import EmployeeDirectory

final class MockDiskImageCache: ImageCache {
    private let memCache = NSCache<NSString, AnyObject>()
    
    func get(for url: URL) -> AnyObject? {
        memCache.object(forKey: url.absoluteString.hashString as NSString)
    }
    
    func insert(to url: URL, data: AnyObject) throws {
        memCache.setObject(data, forKey: url.absoluteString.hashString as NSString)
    }
}
