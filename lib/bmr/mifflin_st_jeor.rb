# frozen_string_literal: true

# The BMR module provides data structures and scientific formulas
# for calculating a person's Basal Metabolic Rate.
module BMR
  # Mifflin St Jeor equation to calculate BMR
  #
  # https://www.thecalculatorsite.com/articles/health/bmr-formula.php
  def self.mifflin_st_jeor(person)
    raise ArgumentError, "Not a BMR::Person object" unless person.is_a?(BMR::Person)

    base_bmr = (4.536 * person.pounds) + (15.88 * person.inches) - (5.0 * person.age)

    person.sex == "female" ? base_bmr - 161.0 : base_bmr + 5.0
  end
end
