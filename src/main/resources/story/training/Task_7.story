Meta:
    @group Training
    @requirementId MyTask-0007


Scenario: Navigate to the website homepage
Given I navigate to the SauceDemo homepage and verify the URL
When I take screenshot

Scenario: Log In
When I login with username `${swagGoodUserName}` and password `${swagPassword}`
Then number of elements found by `className(inventory_item)` is equal to `6`
When I take screenshot

Scenario: Add item to the shopping cart
When I click on element located by `id(<addToCartButtonId>)`
When I click an item with name `<itemName>` and verify the page with id `<itemPageId>` is loaded
Then a button with the name 'Remove' exists
When I take screenshot
Examples:
|itemName                  |itemPageId  |addToCartButtonId                     |
|Sauce Labs Backpack       |4           |add-to-cart-sauce-labs-backpack       |

Scenario: Populate checkout data
When I click on element located by `id(shopping_cart_container)`
When I click on element located by `id(checkout)`
When I enter `#{generate(Name.firstName)}` in field located by `id(first-name)`
When I enter `#{generate(regexify '[A-Za-z]{10}')}` in field located by `id(last-name)`
When I enter `#{generate(regexify '[A-Z]{3}-\d{5}')}` in field located by `id(postal-code)`
When I take screenshot

Scenario: Complete checkout process
When I click on element located by `id(continue)`
When I click on element located by `id(finish)`
When I save text of element located by `className(complete-header)` to scenario variable `thank`
Given I initialize scenario variable `file` with value `#{loadResource(/data/message.txt)}`
Then `#{eval(`${file}` == `${thank}`)}` is = `true`
When I take screenshot
