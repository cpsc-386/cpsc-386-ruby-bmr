# frozen_string_literal: true

require_relative "../test_helper"

class MifflinStJeorTest < Minitest::Test
  def test_calculates_correctly_for_females
    female = BMR::Person.new(age: 30, inches: 65, pounds: 150, sex: "female")

    # Expected: (4.536 * 150) + (15.88 * 65) - (5.0 * 30) - 161.0
    # Expected: 680.4 + 1032.2 - 150.0 - 161.0 = 1401.6
    expected_bmr = 1401.6

    # We use in_delta to account for minor floating point imprecisions
    assert_in_delta expected_bmr, BMR.mifflin_st_jeor(female), 0.001
  end

  def test_calculates_correctly_for_males
    male = BMR::Person.new(age: 30, inches: 70, pounds: 180, sex: "male")

    # Expected: (4.536 * 180) + (15.88 * 70) - (5.0 * 30) + 5.0
    # Expected: 816.48 + 1111.6 - 150.0 + 5.0 = 1783.08
    expected_bmr = 1783.08

    assert_in_delta expected_bmr, BMR.mifflin_st_jeor(male), 0.001
  end

  def test_raises_error_if_not_a_person
    # Passing a plain hash or string instead of a BMR::Person
    assert_raises(ArgumentError) { BMR.mifflin_st_jeor({ age: 30, sex: "male" }) }
    assert_raises(ArgumentError) { BMR.mifflin_st_jeor("Just a string") }
  end
end
