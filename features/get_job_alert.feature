Feature: User can receive an email with job alerts

    As a user who is subscribed to WorkLede
    So that I can receive job alerts
    I want to receive job alerts in my email

Scenario: User is able to receive job alerts in his inbox

    Given that I am subscribed to WorkLede
    When I check my email every morning
    Then I'm able to see a new email from WorkLede with job alerts


# this feature is in the works.