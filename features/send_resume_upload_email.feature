Feature: User can receive an email saying that he uploaded his resume successsfully

    As a user who has uploaded his resume
    So that I can add the resume to my profile
    I want to receive an email when the upload is successful

Scenario: User recieves an email saying he uploaded his resume

    Given that I am logged in and on my profile page
    When I upload a resume with a name entered and a file chosen
    Then I'll see receive an email saying the resume was successsfully uploaded

# this feature is in the works.