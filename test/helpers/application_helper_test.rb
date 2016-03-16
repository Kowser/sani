require 'test_helper'
include ApplicationHelper

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title,         				'Sani'
    assert_equal full_title('New Account'), 'Sani | New Account'
  end

  test 'humanize boolean helper' do
  	assert_equal humanize_boolean(true), 		'Yes'
  	assert_equal humanize_boolean(false), 	'No'
  	assert_equal humanize_boolean(nil), 		'No'
  end

  test 'humanize json helper' do
  	assert_equal humanize_json([]),													'None Selected'
  	assert_equal humanize_json(['','Answer 1','Answer 2']),	'Answer 1<br>Answer 2'
  end

  test 'landing menu links helper' do
    assert false, 'need tests for this'
  end
end