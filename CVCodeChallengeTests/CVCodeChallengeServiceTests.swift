import XCTest
@testable import CVCodeChallenge

class CVCodeChallengeTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    var apiServiceUnderTest: ApiService!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: .default)
        apiServiceUnderTest = ApiService()
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        apiServiceUnderTest = nil
        super.tearDown()
    }
    
    func testValidCallToGithub() {
        guard let url = URL(string: "https://gist.githubusercontent.com/prickly-patroller19/b120ff3ca8539e5d292f5d075ce57311/raw/80e80cf3670a118ad539541ad78fe850a871004b/CVInfo") else { return }
        let promise = expectation(description: "Status code: 200")
        var statusCode: Int?
        var responseError: Error?
        let dataTask = sessionUnderTest.dataTask(with: url) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testRequestDataResponseOk() {
        
        let async = expectation(description: "async")
        let mock = MockNetworkRequest()
        mock.localURLString = "CVInfo"
        
        _ = mock.load { result in
            switch result {
            case .success:
                async.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        wait(for: [async], timeout: 1)
    }
    
    func testRequestDataResponseFailBadURL() {
        
        let async = expectation(description: "async")
        let mock = MockNetworkRequest()
        mock.localURLString = "CVBadURLTest"
        
        _ = mock.load { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .badURL)
                async.fulfill()
            }
        }
        
        wait(for: [async], timeout: 1)
    }
    
    func testDecodingJSONOk() {
        let async = expectation(description: "async")
        let mock = MockNetworkRequest()
        mock.localURLString = "CVInfo"
        
        _ = mock.load { result in
            switch result {
            case .success(let data):
                if let _ = mock.decode(data) {
                    async.fulfill()
                } else {
                    XCTFail()
                }
                break
            case .failure:
                XCTFail()
            }
        }
        
        wait(for: [async], timeout: 1)
    }
    
    func testDecodingJSONFail() {
        let async = expectation(description: "async")
        let mock = MockNetworkRequest()
        mock.localURLString = "badCVInfo"
        
        _ = mock.load { result in
            switch result {
            case .success(let data):
                if let _ = mock.decode(data) {
                    XCTFail()
                } else {
                    async.fulfill()
                }
                break
            case .failure:
                XCTFail()
            }
        }
        
       
        wait(for: [async], timeout: 1)
    }
    
    func testAPIServiceReturnSuccess() {
        let promise = expectation(description: "Information loaded")
        apiServiceUnderTest.loadInformation { (result: Result<CVInformation.CodingData, LoadingError>) in
            switch result {
            case .success:
                promise.fulfill()
            case .failure:
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
