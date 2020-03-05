Feature: User can delete his resume

    As a user trying to delete resume
    So that I can remove older resumes from my profile
    I want to delete a resume from my profile

Scenario: User is able to upload his resume

    Given that I am logged in and on my profile page and I have at least one resume 
    When I click on the delete link of one of the resumes
    Then I'll not see the deleted resume when the page refreshes