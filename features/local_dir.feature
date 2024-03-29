Feature: Use local directory to cache github id ,credential and clone gist repos
  In order to list, edit and search gists
  I want to save necessary information to access github

  Scenario: First access to gists api
    Given I don't have any config in local dir
    When I run "gb init --username=username --password=password"
    Then It creates authorization token via github api
    Then The authorization token should be saved to local dir

  @local_profile
  Scenario: Use authtoken in local profile
    Given I have local profile with authentiocation token
    When I run "gb list"
    Then It should fetch gists using authentication token in profile

  @local_profile
  Scenario: Use cached response in local dir
    Given I have cached response in local dir 
    When I run "gb list"
    Then It should fetch gist from local cache

  @local_profile
  Scenario: Clone remote gist as git repository
    Given I don't have local gist repository
    When I run "gb clone 1234567"
    Then It should clone gists repository into local dir
    And It should show local path of the repository

