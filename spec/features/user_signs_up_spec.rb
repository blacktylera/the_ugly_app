feature "User Signs Up" do

  background do
    visit root_path
    click_on "Sign Up"
  end

  scenario "Happy Path" do
    page.should_not have_link("Sign Up")
    fill_in "Name", with: "Tyler"
    fill_in "Email", with: "tyler@tyler.com"
    fill_in "Password", with: "Tubthumping1"
    fill_in "Password confirmation", with: "Tubthumping1"
    click_button "Sign Up"
    page.should have_content("Welcome, Tyler")
    click_on "Sign Out"
    click_on "Sign In"
    fill_in "Email", with: "tyler@tyler.com"
    fill_in "Password", with: "Tubthumping1"
    click_button "Sign In"
    page.should have_content("Welcome back, Tyler")
  end

  scenario "Error Path" do
    fill_in "Name", with: ""
    fill_in "Email", with: "jarjar.com"
    fill_in "Password", with: "Tubthumping1"
    fill_in "Password confirmation", with: "hey"
    click_on "Sign Up"
    page.should have_css(".alert", text: "Please fix the errors below to continue.")

    page.should have_css(".user_name .error", text: "can't be blank")
    page.should have_css(".user_email .error", text: "must be an email address")
    page.should have_css(".user_password_confirmation .error", text: "doesn't match Password")

    fill_in "Name", with: "Timmy"
    fill_in "Email", with: "timmy@braniac.com"
    fill_in "Password", with: "Tubthumping1"
    fill_in "Password confirmation", with: "Tubthumping1"
    click_on "Sign Up"
    page.should have_content("Welcome, Timmy")
  end
end