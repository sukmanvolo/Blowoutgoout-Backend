require "application_system_test_case"

class StylistsTest < ApplicationSystemTestCase
  setup do
    @stylist = stylists(:one)
  end

  test "visiting the index" do
    visit stylists_url
    assert_selector "h1", text: "Stylists"
  end

  test "creating a Stylist" do
    visit stylists_url
    click_on "New Stylist"

    click_on "Create Stylist"

    assert_text "Stylist was successfully created"
    click_on "Back"
  end

  test "updating a Stylist" do
    visit stylists_url
    click_on "Edit", match: :first

    click_on "Update Stylist"

    assert_text "Stylist was successfully updated"
    click_on "Back"
  end

  test "destroying a Stylist" do
    visit stylists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stylist was successfully destroyed"
  end
end
