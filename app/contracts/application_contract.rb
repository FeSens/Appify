# frozen_string_literal: true

require "dry-validation"

Dry::Validation.load_extensions(:predicates_as_macros)

class ApplicationContract < Dry::Validation::Contract
  import_predicates_as_macros
end
