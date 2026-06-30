# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Palmshed

# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/nuntius'

class TestDeprecation < Minitest::Test
  def setup
    # Use a mock API key for testing
    @api_key = 'AIzaSyDummyTestKeyForUnitTests123456789'
  end

  def test_deprecated_model_defaults_to_pro
    # Test that deprecated models default to pro without error
    client = Nuntius::Client.new(@api_key, model: :pro_1_5)

    assert_instance_of Nuntius::Client, client
  end

  def test_deprecated_model_flash_1_5_defaults_to_pro
    # Test another deprecated model
    client = Nuntius::Client.new(@api_key, model: :flash_1_5)

    assert_instance_of Nuntius::Client, client
  end

  def test_deprecated_model_flash_8b_defaults_to_pro
    # Test another deprecated model
    client = Nuntius::Client.new(@api_key, model: :flash_8b)

    assert_instance_of Nuntius::Client, client
  end
end
