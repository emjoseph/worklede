Feature: User can receive an email with their latest job matches
    As a user who has uploaded his resume
    So that I can see my latest job matches
    I want to receive an email with the latest job matches

Scenario: User receives an email saying he uploaded his resume

    Given that I have created an account and have upload a resume
    When I check my email
    Then I should see an email from Worklede with my latest job matches
