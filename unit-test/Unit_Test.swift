import XCTest

// unit test : 도메인, 로직에 대한 테스트 작성
// input 사용 금지, 100회든 10,000회든 반복적으로 테스팅이 가능해야함
// 각 테스트 케이스는 독립적인 단위여야함
// 현실세계에서 발생할 수 있는 케이스에 대해서만 유닛 테스트를 작성하면 됨

final class when_calculating_tip_based_on_total_amout: XCTestCase {
    // test 키워드로 시작하기
    func test_should_calculate_tip_successfully() {
        let tipCalculator = TipCalculator()
        let tip = try! tipCalculator.calculate(total: 100, tipPercentage: 0.1)
        XCTAssertEqual(10.0, tip)
    }
}

class when_calculating_tip_based_on_negative_total_amount: XCTestCase {
    func test_should_throw_invalid_input_exception() {
        let tipCalculator = TipCalculator()
        XCTAssertThrowsError(try tipCalculator.calculate(total: -100, tipPercentage: 0.1), "") { error in
            XCTAssertEqual(error as! TipCalculatorError, TipCalculatorError.invalidInput)
        }
    }
}
