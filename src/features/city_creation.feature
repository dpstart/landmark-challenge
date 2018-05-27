Feature: As Admin I want to Create new cities

    Scenario: An Admin create new city, which is added to the dataset
        Given I'm admin logged-in
        When I request to create new City
        Then I shoul be replied with 'city_created'