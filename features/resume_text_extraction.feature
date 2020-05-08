Feature: Our NLP engine can extract nouns from a PDF resume for matching

    As a user who uploads a resume
    So that I can receive relevant job matches
    I want to use a service that has a robust NLP engine which can product good matches

Scenario: Worklede NLP engine extracts nouns from PDF resume

    Given that a pdf resume is uploaded to Worklede
    When the system has finished parsing the resume
    Then all the text will be properly extracted
