//
//  UIImageViewTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 24.05.2022.
//

@testable import CountriesApp
import XCTest

final class UIImageViewTests: XCTestCase {

    private var sut: UIImageView?

    override func setUp() {
        super.setUp()
        sut = UIImageView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testloadUsingCache() {
        let urlString = "https://mockurl"
        let dataTask = MockURLSessionDataTask()
        let session = MockURLSession(dataTask: dataTask)
        let imageManager = ImageManager(session: session)

        let task = sut?.loadUsingCache(from: urlString, imageManager: imageManager)

        XCTAssertNotNil(task)
    }

}
