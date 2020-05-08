Feature: User receives reporting related job matches for a resume with reporting experience

    As a user who uploads a resume with reporting experience
    So that I can receive relevant job matches
    I want the top returned match to be for a reporting job

Scenario: User with a reporting focused resume gets matched to a reporting job

    Given that my resume with reporting focused experience has been parsed and is ready to be matched
    When the matching algorithm process is complete
    Then the top job match will be for a reporting job
