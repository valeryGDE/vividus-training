Scenario: Navigate to the website homepage
Given I navigate to the SauceDemo homepage and verify the URL
When I take screenshot

Scenario: Log in as Locked User
Given I navigate to the SauceDemo homepage and verify the URL
When I login with username `${swagLockedUserName}` and password `${swagPassword}`
Then number of elements found by `className(inventory_item)` is equal to `6`
When I take screenshot
