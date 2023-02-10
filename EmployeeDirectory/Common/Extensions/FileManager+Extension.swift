//
//  FileManager+Extension.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import Foundation

extension FileManager {
    var imageCacheURL: URL {
        let cacheURL = urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cacheURL.appendingPathComponent("\(Constants.ImageCache.folderName)")
    }
}
