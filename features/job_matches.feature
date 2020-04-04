Feature: User can see job matches on his profile page

    As a user signed in to WorkLede
    So that I can view job alerts
    I want to view job matches on my profile page when I upload a resume

Scenario: User is able to see a job matches section

    Given that I am signed into WorkLede
    When I upload a resume with a name and a file chosen
    Then I'm able to see a job matches section