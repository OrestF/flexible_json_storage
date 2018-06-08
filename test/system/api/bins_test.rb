require "application_system_test_case"

class Api::BinsTest < ApplicationSystemTestCase
  setup do
    @api_bin = api_bins(:one)
  end

  test "visiting the index" do
    visit api_bins_url
    assert_selector "h1", text: "Api/Bins"
  end

  test "creating a Bin" do
    visit api_bins_url
    click_on "New Api/Bin"

    click_on "Create Bin"

    assert_text "Bin was successfully created"
    click_on "Back"
  end

  test "updating a Bin" do
    visit api_bins_url
    click_on "Edit", match: :first

    click_on "Update Bin"

    assert_text "Bin was successfully updated"
    click_on "Back"
  end

  test "destroying a Bin" do
    visit api_bins_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bin was successfully destroyed"
  end
end
