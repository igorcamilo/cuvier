import XCTest
@testable import MastodonKit

final class MastodonKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        let content = "\u{003c}p\u{003e}Glad America canceled the pandemic also, that was getting sooo annoying to deal with 🤪 \u{003c}a href=\"https://radical.town/tags/BackOnTheGrind\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\"\u{003e}#\u{003c}span\u{003e}BackOnTheGrind\u{003c}/span\u{003e}\u{003c}/a\u{003e} 💪🏻 \u{003c}a href=\"https://radical.town/tags/PaperChasing\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\"\u{003e}#\u{003c}span\u{003e}PaperChasing\u{003c}/span\u{003e}\u{003c}/a\u{003e} \u{003c}a href=\"https://radical.town/tags/GuapAcquirer\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\"\u{003e}#\u{003c}span\u{003e}GuapAcquirer\u{003c}/span\u{003e}\u{003c}/a\u{003e}\u{003c}/p\u{003e}"
        let content = "<p>Two spiders, perfectly (naturally) lit as to appear as but white sparks against their habitat. ^_^</p><p><a href=\"https://lgbt.io/tags/WildlifePhotography\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>WildlifePhotography</span></a></p>"
        print(HTMLParser().parse(string: content).string)
//        XCTAssertEqual(MastodonKit().text, "Hello, World!")
    }
}
