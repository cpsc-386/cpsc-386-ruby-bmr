# frozen_string_literal: true

module BMR
  class InvalidAgeError < StandardError; end
  class InvalidInchesError < StandardError; end
  class InvalidPoundsError < StandardError; end
  class InvalidSexError < StandardError; end

  # Represents an immutable Person with an age, inches, and pounds.
  #
  # Built as a lightweight, value-based Data object to ensure immutability
  # and structural equality. Includes custom exception classes for handling
  # validation errors.
  Person = Data.define(:age, :inches, :pounds, :sex) do
    def initialize(age:, inches:, pounds:, sex:)
      raise InvalidAgeError, "#{age} not a valid age" unless age.is_a?(Numeric) && age.positive?
      raise InvalidInchesError, "#{inches} not a valid height" unless inches.is_a?(Numeric) && inches.positive?
      raise InvalidPoundsError, "#{pounds} not a valid weight" unless pounds.is_a?(Numeric) && pounds.positive?
      raise InvalidSexError, "#{sex} not a valid sex" unless %w[male female].include?(sex)

      super
    end

    def to_s
      "#{sex}, #{inches} inches, #{pounds} pounds, #{age} years old"
    end
  end
end
