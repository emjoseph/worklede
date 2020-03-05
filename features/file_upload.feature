Feature: User can upload his resume

    As a user trying to upload resume
    So that I can add the resume to my profile
    I want to add resume files to my profile

Scenario: User is able to upload his resume
    
    Given that I am on my profile page
    When I click on the Upload button and upload a file
    Then I can see the filename next to the Upload button
