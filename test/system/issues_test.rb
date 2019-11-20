require "application_system_test_case"

class IssuesTest < ApplicationSystemTestCase
  setup do
    @issue = issues(:one)
  end

  test "visiting the index" do
    visit issues_url
    assert_selector "h1", text: "Issues"
  end

  test "creating a Issue" do
    visit issues_url
    click_on "New Issue"

    fill_in "Description", with: @issue.Description
    fill_in "Priority", with: @issue.Priority
    fill_in "Status", with: @issue.Status
    fill_in "Title", with: @issue.Title
    fill_in "Type", with: @issue.Type
    fill_in "Votes", with: @issue.Votes
    fill_in "Assignee", with: @issue.assignee_id
    fill_in "Attachment content type", with: @issue.attachment_content_type
    fill_in "Attachment file name", with: @issue.attachment_file_name
    fill_in "Attachment file size", with: @issue.attachment_file_size
    fill_in "Attachment update at", with: @issue.attachment_update_at
    fill_in "User", with: @issue.user_id
    click_on "Create Issue"

    assert_text "Issue was successfully created"
    click_on "Back"
  end

  test "updating a Issue" do
    visit issues_url
    click_on "Edit", match: :first

    fill_in "Description", with: @issue.Description
    fill_in "Priority", with: @issue.Priority
    fill_in "Status", with: @issue.Status
    fill_in "Title", with: @issue.Title
    fill_in "Type", with: @issue.Type
    fill_in "Votes", with: @issue.Votes
    fill_in "Assignee", with: @issue.assignee_id
    fill_in "Attachment content type", with: @issue.attachment_content_type
    fill_in "Attachment file name", with: @issue.attachment_file_name
    fill_in "Attachment file size", with: @issue.attachment_file_size
    fill_in "Attachment update at", with: @issue.attachment_update_at
    fill_in "User", with: @issue.user_id
    click_on "Update Issue"

    assert_text "Issue was successfully updated"
    click_on "Back"
  end

  test "destroying a Issue" do
    visit issues_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Issue was successfully destroyed"
  end
end
