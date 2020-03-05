Feature: User can upload his resume and see it

    As a user trying to upload resume
    So that I can add the resume to my profile
    I want to add resume files to my profile

Scenario: User is able to upload his resume

    Given that I am logged in and on my profile page
    When I upload a resume with a name entered and a file chosen
    Then I'll see the new resume when the page refreshes
