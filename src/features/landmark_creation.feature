Feature: Add new landmarks to the dataset

  Scenario: An admin creates a new landmark, which is added to the dataset
    Given I'm a logged-in admin
    When I request to create a new landmark
    Then I should be replied with a message indicating the operation was successful
