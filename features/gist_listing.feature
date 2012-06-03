Feature: List public and private gists
  In order to manupulate all the gists I created
  I want to list the gists by type,date,and titles

  @local_profile
  Scenario: index all gists
    Given I have local profile with authentiocation token
    When I run list command
    Then I should see my gists
    And It is sorted by date
