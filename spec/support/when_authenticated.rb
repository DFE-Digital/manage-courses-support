RSpec.shared_context 'when authenticated' do
  before do
    page.driver.browser.authorize("super.admin@education.gov.uk", "beta")
  end
end
