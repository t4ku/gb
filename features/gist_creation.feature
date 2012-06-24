Feature: Create gist from specified files or directory
  As a coder who does programming mainly in terminal 
  In order to avoid distraction
  I want to simply create files and upload to gists

  Scenario: Upload single file
    Given I have created a note as a markdown file
    When I run "gb create -s "
    Then It posts the file
    And display the gist information such as gist url and description

