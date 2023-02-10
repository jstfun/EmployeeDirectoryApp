//
//  ImageCacheTests.swift
//  EmployeeDirectoryTests
//
//  Created by hope on 2/9/23.
//

import XCTest
@testable import EmployeeDirectory

final class ImageCacheTests: XCTestCase {
    private var cacheURL: URL!
    private var diskCache: ImageCache!
    
    private func cleanupCacheStorage() throws {
        var isDir: ObjCBool = true
        let cachePath = cacheURL.path
        
        if !FileManager.default.fileExists(atPath: cachePath, isDirectory: &isDir) {
            return
        }
        
        let filePaths = try FileManager.default.contentsOfDirectory(at: cacheURL,
                                                                    includingPropertiesForKeys: nil,
                                                                    options: [])
        for filePath in filePaths {
            try FileManager.default.removeItem(at: filePath)
        }
    }
    
    override func setUpWithError() throws {
        let rootURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheURL = rootURL.appendingPathComponent("TestImageCache")
        diskCache = FileDiskImageCache(folderName: "TestImageCache")
        
        try cleanupCacheStorage()
    }
    
    override func tearDownWithError() throws {
        try cleanupCacheStorage()
        diskCache = nil
    }
    
    func testGetImage_WhenCached_ShouldImageFileExist() throws {
        let samplePhotoURLString = "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg"
        let imageURL = URL(string: samplePhotoURLString)!
        
        let cached = diskCache.get(for: imageURL)
        XCTAssertNil(cached, "Expected nil image returned")
        
        let bundle = Bundle(for: type(of: self).self)
        let mockImageURL = bundle.url(forResource: "photo_small", withExtension: "jpg")!
        let mockImageData = try? Data(contentsOf: mockImageURL) as AnyObject
        try diskCache.insert(to: imageURL, data: mockImageData!)
        
        let url = cacheURL.appendingPathComponent(imageURL.absoluteString.hashString)
        
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path), "Expected cached iamge existing on file storage.")
    }
}
