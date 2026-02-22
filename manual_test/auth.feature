Feature: Authentication

  Scenario: User Login
    Given a user with username "some_username" and password "somePassword123_"
    When user login with username "some_username" and password "somePassword123_"
    Then the user must be in "Stock List Screen"
    And User name in top-right corner of or profile button is "some_username"
    When user refresh the browser or reopen the app
    Then Then the user must be in Stock List Screen

  Scenario: User Logout
    Given a user already login with username "some_username" and password "somePassword123_" in "Stock List Screen"
    When user logout
    Then the user must be in "Login Screen"
    When user refresh the browser or reopen the app
    Then the user must be in "Login Screen"