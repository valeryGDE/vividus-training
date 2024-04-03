Meta:
    @group Training
    @requirementId MyTask-0006

Lifecycle:
Examples:
|username              |
|${swagGoodUserName}   |
|${swagSlowUserName}   |

Scenario: Navigate to the website homepage
Given I navigate to the SauceDemo homepage and verify the URL
When I take screenshot

Scenario: Log In
When I login with username `<username>` and password `${swagPassword}`
Then number of elements found by `className(inventory_item)` is equal to `6`
When I take screenshot

Scenario: Add item to the shopping cart
When I click on element located by `id(<addToCartButtonId>)`
When I click an item with name `<itemName>` and verify the page with id `<itemPageId>` is loaded
Then a button with the name 'Remove' exists
When I click on element located by `id(back-to-products)`
And I wait until element located by `id(inventory_container)` appears
Examples:
|itemName                  |itemPageId  |addToCartButtonId                     |
|Sauce Labs Backpack       |4           |add-to-cart-sauce-labs-backpack       |
|Sauce Labs Onesie         |2           |add-to-cart-sauce-labs-onesie         |
|Sauce Labs Fleece Jacket  |5           |add-to-cart-sauce-labs-fleece-jacket  |


Scenario: Validate the num of items in the shopping cart
When I click on element located by `id(shopping_cart_container)`
Then number of elements found by `className(cart_item)` is equal to `3`

Scenario: Log Out
When I click on element located by `id(react-burger-menu-btn)`
When I click on element located by `id(reset_sidebar_link)`
When I click on element located by `id(logout_sidebar_link)`
When I wait until element located by `caseSensitiveText(Swag Labs)` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
