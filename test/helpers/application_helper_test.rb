require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title,         				'Sani'
    assert_equal full_title('New Account'), 'Sani | New Account'
  end
end
