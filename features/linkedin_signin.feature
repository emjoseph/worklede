Feature: User sign in

    As a user trying to sign in to WorkLede
    So that I can use WorkLede
    I want to be directed to my profile page

Scenario: User directly goes to his profile

    Given that I am on the home page
    When I click on the Log In link
    Then I am redirected to his profile page
