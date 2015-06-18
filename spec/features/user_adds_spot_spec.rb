feature "user creates a spot" do
  # As a user
  # I want to be able to add a 'spot'. This Consists of Name, Picture, Address,
  # Phone, Type, and The Good, The Bad and The Ugly.

  # Acceptance Criteria:
  # * Post must have all criteria
  # * Post must be publicly visible once saved

  background do
    pending
  end

  scenario "logged out users can't create spots" do
    visit root_path
    page.should_not have_content("Add a Spot!")
    visit new_post_path
    should_be_denied_access
  end

  scenario "happy path" do
    me = Fabricate(:user, name: "Tyler")
    signin_as me
    click_on "Add a Spot!"
    fill_in "Name", with: "Gabbie's Burgers"
    fill_in "Picture", with: "http://gallivant.com/p/2012/10/gabbys-1.jpg"
    fill_in "Address", with: "493 Humphreys St, Nashville, TN 37203"
    fill_in "Phone", with: "(615) 733-3119"
    select "(Type) Restaurant"
    fill_in "The Good", with: "Milkshakes are amazing! Try the peach."
    fill_in "The Bad", with: "Saw a rat in the bathroom."
    fill_in "The Ugly", with: "If John is working, tell him you want extra cheese. He probably won't charge you."
    click_on "Add this Spot!"
    page.should have_notice("#{Spot.name} has been added.")
    current_path.should == user_posts_path(me)
    page.should have_link "Gabby's Burgers"
    click_on "Gabby's Burgers"
    page.should have_css("h1", text: "Gabbie's Burgers")
    page.should have_css("img", url: "http://gallivant.com/p/2012/10/gabbys-1.jpg")
    page.should have_css("h2", text: "493 Humphreys St, Nashville, TN 37203")
    page.should have_css("h2", text: "(615) 733-3119")
    page.should have_css("h2", text: "The Good: Milkshakes are amazing! Try the peach.")
    page.should have_css("h2", text: "The Bad: Saw a rat in the bathroom.")
    page.should have_css("h2", text: "The Ugly: If John is working, tell him you want extra cheese. He probably won't charge you.")
    page.should have_css(".author", text: "Tyler")
  end

  scenario "sad path" do
    me = Fabricate(:user, name: "Bob")
    signin_as me
    click_on "Share Some Knowledge"
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_on "Publish Knowledge"
    page.should have_alert("Your knowledge could not be published.  Please correct the errors below.")
    page.should have_error("can't be blank", on: "Title")
    page.should have_error("can't be blank", on: "Body")
  end
end