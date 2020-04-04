Feature: User sees matches after uploading resume

    As a user who is subscribed to WorkLede
    So that I can good job matches
    I want to a match right after I upload a resume

Scenario: User is able to see a match after uploading a resume

    Given that I'm logged in and don't have a resume uploaded
    When I upload a resume and wait for the page to reload
    Then I'll see a job match with a score
