Feature: crepe server

  In order to run a Crepe application from the command line
  As a developer using Crepe
  I want to use the `crepe server` command

  Scenario: with no crepe application
    When I run `crepe server`
    Then the exit status should be 1
    And the output should contain "ERROR: No such sub-command 'server'"
