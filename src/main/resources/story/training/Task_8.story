Meta:
    @group Training
    @requirementId MyTask-0008

Scenario: Navigate to the website homepage
Given I navigate to the SauceDemo homepage and verify the URL
When I take screenshot

Scenario: Log In
When I login with username `${swagGoodUserName}` and password `${swagPassword}`
Then number of elements found by `className(inventory_item)` is equal to `6`
When I take screenshot

Scenario: Add items to the shopping cart
When I sort the items by `<sortingValue>`
When I click on element located by `xpath((//button[text()='Add to cart'])[1])`
When I save text of element located by `xpath((//div[@class="inventory_item_price"])[1])` to story variable `price<cartBadgeCount>`
Then an element with the name 'shopping_cart_badge' and text '<cartBadgeCount>' exists
When I take screenshot
Examples:
|sortingValue           |cartBadgeCount  |
|Price (low to high)    |1               |
|Price (high to low)    |2               |

Scenario: Populate checkout data
When I click on element located by `id(shopping_cart_container)`
When I click on element located by `id(checkout)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-one.html`
When I ${baselineAction} baseline with name `info` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE	|
|5				            |
When I Populate checkout data with first name `#{generate(Name.firstName)}` and last name `#{generate(regexify '[A-Za-z]{10}')}` and zip code `#{generate(regexify '[A-Z]{3}-\d{5}')}`
When I take screenshot

Scenario: Validate order summary and complete order
When I click on element located by `id(continue)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I ${baselineAction} baseline with name `overview` ignoring:
|ELEMENT	                            |
|By.cssSelector(.cart_item_label, .cart_quantity, .summary_value_label, .summary_subtotal_label, .summary_tax_label, .summary_total_label)          |
When I save text of element located by `xpath(//div[@class="summary_subtotal_label"])` to story variable `totalPrice`
Then `#{eval(new('java.math.BigDecimal', stringUtils:substringAfterLast('${totalPrice}', '$'), new('java.math.MathContext', 4)) == new('java.math.BigDecimal', stringUtils:substringAfterLast('${price1}', '$')) + new('java.math.BigDecimal', stringUtils:substringAfterLast('${price2}', '$')))}` is = `true`
When I click on element located by `id(finish)`
When I save text of element located by `className(complete-header)` to scenario variable `thank`
Given I initialize scenario variable `file` with value `#{loadResource(/data/message.txt)}`
Then `#{eval(`${file}` == `thank`)}` is = `true`
When I take screenshot
