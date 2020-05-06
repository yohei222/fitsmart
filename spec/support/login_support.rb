module LoginSupport
  def sign_in_as(user)
    visit root_path
    within "#login" do
      click_link "ログイン"
    end
    fill_in "Eメール", with: user.email
    fill_in "exampleInputPassword1", with: user.password
    find('#submit-btn').click
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
