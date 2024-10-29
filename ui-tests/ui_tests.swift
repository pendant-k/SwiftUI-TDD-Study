//
//  ui_tests.swift
//  ui-tests
//
//  Created by Donghan Kim on 10/29/24.
//

import XCTest

final class content_view_보여질때: XCTestCase {
    // test case 프로퍼티 변수로 app 선언,
    // setUp 매서드 내에서 app 변수에 실제 인스턴스 할당하여 각 단위테스트에서 app 변수를 활용
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!

    override func setUp() {
        // app 인스턴스 할당
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        // 에러 발생 시 테스트 종료
        continueAfterFailure = false
        // 앱 실행
        app.launch()
    }

    func test_total_text_field_기본값_가지는지_확인() {
        XCTAssertEqual(contentViewPage.totalTextField.value as! String, "Enter total")
    }

    func test_기본팁_20퍼센트_확인() {
        // TODO: checkout segmentedControls
        // boundBy -> 인덱스 1의 버튼 가져오기
        let segmentedControlButton = contentViewPage.tipPercentageSegmentedControl.buttons.element(boundBy: 1)

        XCTAssertEqual(segmentedControlButton.label, "20%")
        XCTAssertTrue(segmentedControlButton.isSelected)
    }

    override func tearDown() {
        // clean up
    }
}

class when_calculate_tip_button_is_pressed_for_valid_input: XCTestCase {
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!

    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()

        let totalTextField = contentViewPage.totalTextField
        totalTextField.tap()
        totalTextField.typeText("100")

        // Button View의 label을 가져옴..
        // Button은 못가져오나?
        let calculateTipButton = contentViewPage.calculateTipButton

        calculateTipButton.tap()
    }

    func test_should_make_sure_that_tip_is_displayed_on_the_screen() {
        let tipText = contentViewPage.tipText
        let _ = tipText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(tipText.label, "20.0")
    }
}

class when_calculate_tip_button_is_pressed_for_invalid_input: XCTestCase {
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!

    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()

        let totalTextField = contentViewPage.totalTextField
        totalTextField.tap()
        totalTextField.typeText("-100")
        let calculateTipButton = contentViewPage.calculateTipButton

        calculateTipButton.tap()
    }

    func test_should_clear_tip_label_for_invalid_input() {
        let tipText = contentViewPage.tipText
        let _ = tipText.waitForExistence(timeout: 0.5)

        XCTAssertEqual(tipText.label, "")
    }

    func test_should_display_error_message_for_invalid_input() {
        let messageText = contentViewPage.messageText
        let _ = messageText.waitForExistence(timeout: 0.5)

        XCTAssertEqual(messageText.label, "Invalid Input")
    }
}
