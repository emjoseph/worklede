Feature: User can see latest job in our system on his profile page

    As a user signed in to WorkLede
    So that I can view job alerts
    I want to view the latest five jobs on my profile page

Scenario: User is able to see a job matches section with only the latest five jobs

    Given that I am signed into WorkLede
    When I visit the home page to see the latest jobs
    Then I see a section with the latest jobs and it only contains the latest five jobs posted
