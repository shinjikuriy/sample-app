require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links not logged in" do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', signup_path

    get signup_path
    assert_select 'title', full_title("Sign up")

    get help_path
    assert_select 'title', full_title("Help")

    get login_path
    assert_select 'title', full_title("Log in")

    get about_path
    assert_select 'title', full_title("About")

    get contact_path
    assert_select 'title', full_title("Contact")
  end

  test "layout links logged in" do
    log_in_as @user

    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', signup_path

    get signup_path
    assert_select 'title', full_title("Sign up")

    get help_path
    assert_select 'title', full_title("Help")

    get about_path
    assert_select 'title', full_title("About")

    get contact_path
    assert_select 'title', full_title("Contact")

    get users_path
    assert_select 'title', full_title("All users")

    get user_path(@user)
    assert_select 'title', full_title(@user.name)

    get edit_user_path(@user)
    assert_select 'title', full_title("Edit user")
  end

end
