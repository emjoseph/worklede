Feature: Users should only see job matches with high scores

    As a user who uploads a resume
    So that I can receive relevant job matches
    I want the returned matches to be relevant to my expertise

Scenario: A user should not receive emails for jobs with low match scores

    Given that I have created an account and have upload a resume
    When I check my email after matches have been processed and there were no high matches
    Then I should not see an email from Worklede with my latest job matches
