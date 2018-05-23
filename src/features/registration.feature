Feature: Register new users via email and password

  Scenario: Make registration possible for new users via a JSON API
    Given I'm not a registered user
    When I make a request to signup to the website
    Then I should be replied with 'success'
