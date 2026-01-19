@mod @mod_hotquestion
Feature: Testing overview integration in hotquestion activity
  In order to summarize the hotquestion activity
  As a user
  I need to be able to see the hotquestion activity overview

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1        | 0        | 1         |
    And the following "users" exist:
      | username | firstname | lastname | email            |
      | teacher1 | Teacher   | 1        | teacher1@asd.com |
      | student1 | Student   | 1        | student1@asd.com |
      | student2 | Student   | 2        | student2@asd.com |
      | student3 | Student   | 3        | student3@asd.com |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | student1 | C1     | student        |
      | student2 | C1     | student        |
      | student3 | C1     | student        |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on
    And I add a hotquestion activity to course "Course 1" section "1"
    And I set the following fields to these values:
      | Activity Name      | Test Hot Question name        |
      | Description        | Test Hot Question Description |
      | cmidnumber         | TestHotQuestion               |
      | viewaftertimeclose | 0                             |
    And I press "Save and return to course"
    And I log out

  @javascript
  Scenario: The hotquestion activity overview report should generate log events
    Given the site is running Moodle version 5.0 or higher
    And I am on the "Course 1" "course > activities > hotquestion" page logged in as "teacher1"
    When I am on the "Course 1" "course" page logged in as "teacher1"
    And I navigate to "Reports" in current page administration
    And I click on "Logs" "link"
    And I click on "Get these logs" "button"
    Then I should see "Course activities overview page viewed"
    And I should see "viewed the instance list for the module 'hotquestion'"

  @javascript
  Scenario: The hotquestion activity index redirect to the activities overview
    Given the site is running Moodle version 5.0 or higher
    When I am on the "C1" "course > activities > hotquestion" page logged in as "admin"
    Then I should see "Name" in the "hotquestion_overview_collapsible" "region"
    And I should see "Actions" in the "hotquestion_overview_collapsible" "region"
    And I should see "Test Hot Question name"
