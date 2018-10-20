# eureka
Eureka 👨‍💻

## Decision
+ `ViewModel` is responsible to handle the business logic of the app. Please take a look at the following diagram to understand how to transform the signals.
+ `HexDecoder`, which is adopted `HexDecoderType`. This class is responsible for checking the input if it's valid color or one of defined-color. It results in the NSColor => Losse-coupling with `ViewModel` => Able to write a unit test to test independently.
 + `Result<T>` enum, which is a useful technique I learned from Moya library to determine if it's error or success. It works well with RxSwift.

## Technology stack
+ MVVM
+ RxSwift
+ RxCocoa

## Diagram
![alt text](https://github.com/NghiaTranUIT/eureka/blob/master/diagram.png)

## Unit tests
### [HexDecoderTests](https://github.com/NghiaTranUIT/eureka/blob/master/AssignmentTests/HexDecoderTests.swift)
1. testDecoderWithInvalidHexColor()
2. testDecoderWithValidHexColor()
3. testDecoderWithDefinedText()
4. testDecoderWithUndefinedText()

### [ViewModel](https://github.com/NghiaTranUIT/eureka/blob/master/AssignmentTests/ViewModelsTests.swift)
1. testEmptyTextShouldShowErrorAndDontShowPopup()
2. testValidColorShouldShowPopupAndChangeColorAndHideErrorLabel()
3. testValidDefinedTextColorShouldShowPopupAndChangeColorAndHideErrorLabel() 
4. testInvalidDefinedTextColorShouldNotShowPopupAndChangeColorButShowErrorLabel()
