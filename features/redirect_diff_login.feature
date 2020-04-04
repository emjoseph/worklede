Feature: User cannot see other user's profiles

    As a user trying to view some other user's profile
    So that I can see their resumes
    I want to see their profile

Scenario: User is unable to view other user's profile

    Given that I am signed up and on my profile page
    When I change the link to other user's id
    Then I'm redirected back to my profile page