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
        guard let url = URL(string: "https://raw.githubusercontent.com/ricardoisidro/JSONCV/master/cv.json") else { return }
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
    
    //TODO: Test View model charge of information
    func testCVInformationInitializesCorrectly() {
//        let basicInformation = CVInformation.CodingData.Info(name: "Ricardo", surnames: "Isidro Ramírez", age: "32", nationality: "Mexican")
//        let job = Job(job: "Developer", place: "Globant", start: "Mar 2019", end: "Current")
//        let skill = Skill(skill: "iOS")
//        let completeInformation = CVInformation.CodingData(info: basicInformation, experience: [job], skills: [skill])
//
//        XCTAssertEqual(completeInformation.info.name, "Ricardo")
//        XCTAssertEqual(completeInformation.info.age, "32")
//        XCTAssertEqual(completeInformation.info.nationality, "Mexican")
//        XCTAssertEqual(completeInformation.experience.first?.job, "Developer")
//        XCTAssertEqual(completeInformation.skills.first?.skill, "iOS")
    }
}
