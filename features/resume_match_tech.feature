Feature: User receives tech related job matches for a more technical resume

    As a user who uploads a resume with technical experience (i.e software development)
    So that I can receive relevant job matches
    I want the top returned match to be for a software development job

Scenario: User with a technical resume gets matched to a technical job

    Given that my resume with software development experience has been parsed and is ready to be matched
    When the matching algorithm is complete
    Then the top job match will be for a software development job
