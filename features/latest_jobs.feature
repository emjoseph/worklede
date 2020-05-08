Feature: User can see latest job in our system on his profile page

    As a user signed in to WorkLede
    So that I can view job alerts
    I want to view the latest jobs on my profile page

Scenario: User is able to see a job matches section

    Given that I am signed into WorkLede
    When I visit the home page
    Then I see a section with the latest jobs
