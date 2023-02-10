//
//  EmployeeListViewModelTests.swift
//  EmployeeDirectoryTests
//
//  Created by hope on 2/9/23.
//

import XCTest
@testable import EmployeeDirectory

final class EmployeeListViewModelTests: XCTestCase {
    private var viewModel: EmployeeListViewModel!
    private var imageRepository: ImageRepository!
    
    override func setUp() {
        let mockAPIService = MockAPIService()
        let employeeRemoteDataSource = EmployeeRemoteDataSource(mockAPIService)
        let employeeRepository = EmployeeRepositoryImp(remoteDataSource: employeeRemoteDataSource)
        let getEmployeesUseCase = GetEmployeesUseCase(employeeRepository: employeeRepository)
        
        let mockDiskImageCache = MockDiskImageCache()
        imageRepository = ImageRepositoryImp(localDataSource: ImageLocalDataSource(diskCache: mockDiskImageCache),
                                                 remoteDataSource: ImageRemoteDataSource(mockAPIService))
        let getImageUseCase = GetImageUseCase(repository: imageRepository)
        
        viewModel = EmployeeListViewModel(getEmployeesUseCase: getEmployeesUseCase,
                                          getImageUseCase: getImageUseCase)
    }
    
    override func tearDown() {
        imageRepository = nil
        viewModel = nil
    }

    func testGetEmployees_WhenNetworkingError_ShouldDisplayErrorAlert() async {
        MockURLProtocol.requestHandler = { _ in
            throw NSError(domain: "Network Error", code: 1000)
        }

        let _ = await viewModel.getEmployees()
        XCTAssertTrue(viewModel.showAlert, "Expected error alert enabled")
        XCTAssertEqual(viewModel.alertMessage, AppMessage.failedLoadingEmployees, "Expected failed loading employees")
    }

    func testGetEmployees_WhenFetchedRemoteEmployeesData_ShouldGetTeamEmployees() async throws {
        let employees = loadJSONEncoded(bundle: Bundle(for: type(of: self).self), file: "employees.json")

        MockURLProtocol.requestHandler = { _ in (HTTPURLResponse(), employees) }

        let _ = await viewModel.getEmployees()
        XCTAssertFalse(viewModel.showAlert, "Expected no error alert")
        let teams = viewModel.teamEmployeesList.map { $0.team }
        XCTAssertEqual(teams.count, 10, "Expected teams are equal")
        
    }
    
    func testGetEmployees_WhenFetchedEmptyData_ShouldGetEmptyTeamEmployees() async throws {
        let employees = loadJSONEncoded(bundle: Bundle(for: type(of: self).self), file: "employees_empty.json")

        MockURLProtocol.requestHandler = { _ in (HTTPURLResponse(), employees) }
        
        let _ = await viewModel.getEmployees()
        XCTAssertFalse(viewModel.showAlert, "Expected no error alert")
        let teams = viewModel.teamEmployeesList.map { $0.team }
        XCTAssertEqual(teams.count, 0, "Expected empty teams")
    }
    
    func testGetImage_WhenAfterFetchedRemoteEmployeesData_ShouldGetValidCachedImageData() async {
        let bundle = Bundle(for: type(of: self).self)
        let data = loadJSONEncoded(bundle: bundle, file: "employees.json")

        MockURLProtocol.requestHandler = { _ in (HTTPURLResponse(), data) }
        
        let _ = await viewModel.getEmployees()
        if viewModel.showAlert {
            XCTFail("Failed to fetch employees.")
        }
        
        let firstEmployee = viewModel.teamEmployeesList.first?.employees.first
        let photoURLString =  firstEmployee?.photoUrlSmall
        XCTAssertNotNil(photoURLString, "Expected photo URL string to be a not nil")
        
        let mockImageURL = bundle.url(forResource: "photo_small", withExtension: "jpg")!
        let mockImage = try? Data(contentsOf: mockImageURL)
        MockURLProtocol.requestHandler = { _ in (HTTPURLResponse(), mockImage!) }
        
        let imageData = await viewModel.getImage(for: photoURLString)
        XCTAssertEqual(mockImage, imageData, "Expected both images to be equal.")
        
        let photoURL = URL(string: photoURLString!)
        XCTAssertNotNil(photoURL, "Expected photo URL to be a not nil")
        
        let cachedImage = await imageRepository.get(for: photoURL!)
        XCTAssertNotNil(cachedImage, "Expected cached image to be a not nil")
        XCTAssertEqual(cachedImage, mockImage, "Expected both images to be equal")
    }
}
