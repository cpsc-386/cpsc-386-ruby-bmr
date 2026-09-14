# frozen_string_literal: true

require_relative "../test_helper"

class PersonTest < Minitest::Test
  def setup
    @valid_params = {
      age: 35,
      inches: 70.5,
      pounds: 165.2,
      sex: "female"
    }
  end

  def test_successful_initialization
    person = BMR::Person.new(**@valid_params)

    assert_equal 35, person.age
    assert_in_delta(70.5, person.inches)
    assert_in_delta(165.2, person.pounds)
    assert_equal "female", person.sex
  end

  def test_to_s_formatting
    person = BMR::Person.new(**@valid_params)
    expected_string = "female, 70.5 inches, 165.2 pounds, 35 years old"

    assert_equal expected_string, person.to_s
  end

  def test_raises_error_for_invalid_age
    assert_raises(BMR::InvalidAgeError) { BMR::Person.new(**@valid_params, age: 0) }
    assert_raises(BMR::InvalidAgeError) { BMR::Person.new(**@valid_params, age: -5) }
    assert_raises(BMR::InvalidAgeError) { BMR::Person.new(**@valid_params, age: "35") }
  end

  def test_raises_error_for_invalid_inches
    assert_raises(BMR::InvalidInchesError) { BMR::Person.new(**@valid_params, inches: 0) }
    assert_raises(BMR::InvalidInchesError) { BMR::Person.new(**@valid_params, inches: -10) }
    assert_raises(BMR::InvalidInchesError) { BMR::Person.new(**@valid_params, inches: "70.5") }
  end

  def test_raises_error_for_invalid_pounds
    assert_raises(BMR::InvalidPoundsError) { BMR::Person.new(**@valid_params, pounds: 0) }
    assert_raises(BMR::InvalidPoundsError) { BMR::Person.new(**@valid_params, pounds: -150) }
    assert_raises(BMR::InvalidPoundsError) { BMR::Person.new(**@valid_params, pounds: "165.2") }
  end

  def test_raises_error_for_invalid_sex
    assert_raises(BMR::InvalidSexError) { BMR::Person.new(**@valid_params, sex: "alien") }
    assert_raises(BMR::InvalidSexError) { BMR::Person.new(**@valid_params, sex: :female) }
    assert_raises(BMR::InvalidSexError) { BMR::Person.new(**@valid_params, sex: "") }
  end

  def test_immutability
    person = BMR::Person.new(**@valid_params)

    assert_raises(NoMethodError) { person.age = 36 }
    assert_raises(NoMethodError) { person.inches = 72 }
  end
end
