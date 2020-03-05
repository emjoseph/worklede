Feature: User is directed to the landing page when not logged in where they can sign up

    As a user trying to sign up for WorkLede
    When I visit the index page
    I should see buttons to sign up and log in

Scenario: User is redirected to LinkedIn sign in page

    Given that I am not logged in
    When I visit the index page
    Then I should see a button to sign up

Scenario: User is redirected to LinkedIn sign in page

    Given that I am logged in
    When I visit the index page
    Then I should see a button to log out
