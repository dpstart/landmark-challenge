Feature: Login registered user with email and password

  Scenario: Registered users can login to the website to access further functionalities
    Given I'm a registered user
    When I make a request to sign-in using email and password
    Then I should be replied with data containing a representation of the model
