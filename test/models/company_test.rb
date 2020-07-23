require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def setup
    @company = companies(:thompson_patining)
  end

  test "should save if email is valid" do
    company = Company.new(name: "new company", zip_code: "94105", email: "newtest@getmainstreet.com")
    assert company.save
  end

  test "should not save if email is invalid" do
    @company.email = "66#$$90(@cn.com"
    assert_not @company.save
  end

  test "should not save if email domain is invalid" do
    @company.email = "email@anotherdomain.com"
    assert_not @company.save
  end

  test "should allow blank email" do
    company = Company.new(name: "new company", zip_code: "94105", email: "")
    assert company.save
  end

  test "the email must be unique" do
    company = Company.new(name: "Test 1 company", zip_code: "94105", email: "testuniq@getmainstreet.com")
    company.save

    dup_email_company = Company.new(name: "Test 2 company", zip_code: "94105", email: "testuniq@getmainstreet.com")

    assert_not dup_email_company.save
  end

  test "the email be downcase when saved" do
    company = Company.new(name: "Test down company", zip_code: "94105", email: "TESTdOwn@getmainstreet.com")
    company.save
    company.reload
    assert company.email == "testdown@getmainstreet.com"
  end
  # Similarly phone validation can be added.

  test "must not save if invalid zip code" do
    @company.zip_code = "00000"
    assert_not @company.save
  end

  test "must save if valid zipcode" do
    @company.save
    assert_not_nil @company.city
    assert_not_nil @company.state
  end

  test "must update city and state when zip_code updated" do
    @company.save
    old_city = @company.city
    old_state = @company.state

    @company.zip_code = "93003"
    @company.save

    assert_not_equal  old_city, @company.city
    assert_not_equal  old_state, @company.state
  end

end