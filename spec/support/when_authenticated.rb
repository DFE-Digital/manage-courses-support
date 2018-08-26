RSpec.shared_context 'when authenticated' do
  background do
    page.driver.browser.authorize("bat", "beta")
  end
end
