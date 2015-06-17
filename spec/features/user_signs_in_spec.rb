feature "User signs in" do

  before do
    visit "/"
    click_on "Sign In"
    page.should_not have_link("Sign In")
  end

  scenario "Returning customer signs in" do
    user = Fabricate(:user, name: "Tyler")
    fill_in "Email", with: user.email
    fill_in "Password", with: "Tubthumping1"
    click_button "Sign In"
    page.should have_content("Welcome back, Tyler")
    page.should_not have_content("Sign In")
    page.should_not have_content("Sign Up")
    page.should have_content("Sign Out")
    click_on "Sign Out"
    page.should have_content("You have been signed out")
    page.should have_content("Sign In")
    page.should_not have_content("Sign Out")
  end

  scenario "Returning user attempts signin with incorrect password" do
    user = Fabricate(:user, name: "Mallory")
    fill_in "Email", with: user.email
    fill_in "Password", with: "wrongpassword"
    click_button "Sign In"
    page.should have_content("We could not sign you in. Please check your email/password and try again.")
    page.should_not have_content("Create your account")
    page.should_not have_content("Password confirmation")
    field_labeled("Email").value.should == user.email
    fill_in "Password", with: "Tubthumping1"
    click_button "Sign In"
    page.should have_content("Welcome back, Mallory")
  end

  scenario "User signs in with wrong email" do
    Fabricate(:user, email: "booger@bigtrux.com", password: "Tubthumping1", password_confirmation: "Tubthumping1")
    fill_in "Email", with: "booger@bigtrucks.com"
    fill_in("Password", with: "Tubthumping1")
    click_on "Sign In"
    page.should have_content("We could not sign you in. Please check your email/password and try again.")
  end

  scenario "User signs in with blanks" do
    click_on "Sign In"
    page.should have_content("We could not sign you in. Please check your email/password and try again.")
  end
end