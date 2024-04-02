Scenario: Simple login verification
Given I navigate to the SauceDemo homepage and verify the URL
When I login with username `<username>` and password `${swagPassword}`
Then number of elements found by `className(inventory_item)` is equal to `6`
When I take screenshot
Examples:
|username              |
|${swagGoodUserName}   |
|${swagLockedUserName} |
|${swagBrokenUserName} |
|${swagSlowUserName}   |
