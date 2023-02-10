//
//  FileDiskImageCache.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import Foundation

class FileDiskImageCache: ImageCache {
    private let fileManager = FileManager.default
    private let cacheURL: URL
    
    init(folderName: String = Constants.ImageCache.folderName) {
        let rootURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheURL = rootURL.appendingPathComponent("\(folderName)")
        var isDir: ObjCBool = true
        if !fileManager.fileExists(atPath: cacheURL.path, isDirectory: &isDir) {
            do {
                try fileManager.createDirectory(atPath: cacheURL.path, withIntermediateDirectories: true)
            } catch {
                fatalError("Couldn't create image cache folder.")
            }
        }
    }

    func get(for url: URL) -> AnyObject? {
        let filePath = cacheURL.appendingPathComponent(url.absoluteString.hashString)
        return try? Data(contentsOf: filePath) as AnyObject
    }
    
    func insert(to url: URL, data: AnyObject) throws {
        guard let data = data as? Data else {
            throw ImageCacheError.invalidDataType
        }
        
        let imageURL = cacheURL.appendingPathComponent(url.absoluteString.hashString)
        
        // An image URL is not changed unless its image is changed.
        if !fileManager.fileExists(atPath: imageURL.path) {
            if !fileManager.createFile(atPath: imageURL.path, contents: data) {
                throw ImageCacheError.failedInsert
            }
        }
    }
}
