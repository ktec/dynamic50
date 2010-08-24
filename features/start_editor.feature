Feature: Designer starts editor

  As a talented designer
  I want to start a session in my fancy design tool
  So that I can draw pretty pictures

  Scenario: start editor session
    Given I am not already drawing a great picture
    When I start a new session
    Then I should see "Welcome to MS Graphical Editor 2010"
    And I should see "What do you want to draw today?"
