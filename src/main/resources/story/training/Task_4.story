Scenario: Simple login verification
Given I navigate to the SauceDemo homepage and verify the URL
When I login with username `${swagBrokenUserName}` and password `${swagPassword}`
Then number of elements found by `className(inventory_item)` is equal to `6`
When I take screenshot
