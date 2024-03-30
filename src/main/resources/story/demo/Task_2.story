Scenario: Simple login verification
Given I am on main application page
When I wait until element located by `caseSensitiveText(Swag Labs)` appears
When I enter `${swagGoodUserName}` in field located by `id(user-name)`
When I enter `${swagPassword}` in field located by `id(password)`
When I click on element located by `id(login-button)`
When I wait until element located by `id(inventory_container)` appears
Then page title is equal to `Swag Labs`
Then number of elements found by `className(inventory_item)` is equal to `6`
When I take screenshot
