require 'test_helper'

class DashboardHelperTest < ActionView::TestCase
  test 'humanize boolean helper' do
    assert_equal humanize_boolean(true),    'Yes'
    assert_equal humanize_boolean(false),   'No'
    assert_equal humanize_boolean(nil),     'No'
  end

  test 'humanize json helper' do
    assert_equal humanize_json([]),                         'None Selected'
    assert_equal humanize_json(['','Answer 1','Answer 2']), 'Answer 1<br>Answer 2'
  end
end