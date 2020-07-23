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

end