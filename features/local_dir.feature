Feature: Use local directory to cache github id ,credential and clone gist repos
  In order to list, edit and search gists
  I want to save necessary information to access github

  Scenario: First access to gists api
    Given I don't have any config in local dir
    When I run "gb list"
    Then I am asked to enter username and password
    Then The authorization token should be saved to local dir
