Feature: User can receive an email saying that he has signed up for WorkLede

    As a user who has signed up for WorkLede
    So that I can use WorkLede to receive job alerts
    I want to receive an email after I have signed up

Scenario: User receives an email saying he has signed up for WorkLede

    Given that I have signed in using LinkedIn for the first time
    When I successfully login
    Then I will receive an email saying that I have signed up for WorkLede


# this feature is in the works.
