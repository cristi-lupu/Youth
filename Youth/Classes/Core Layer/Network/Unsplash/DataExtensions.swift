import Foundation

extension Data {
    /**
     Returns a Data from indicated file of 'json' extension if running from Test target.
     If running from main target, returns empty Data.

     - parameter testResponseFileName: File name.
     - parameter fileType: File type. Default is "json".
     */
    init(testResponseFileName: String, fileType: String = "json") {
        let testingBundle = Bundle(identifier: "com.cristianlupu.YouthTests")
        let path = testingBundle?.path(forResource: testResponseFileName, ofType: fileType)
        let testData = try? Data(contentsOf: URL(fileURLWithPath: path ?? ""))
        self = testData ?? Data()
    }
}
