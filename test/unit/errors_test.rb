# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Palmshed

# frozen_string_literal: true

require 'test_helper'

class ErrorsTest < Minitest::Test
  def test_error_inheritance
    assert_kind_of StandardError, Nuntius::Error.new
  end

  def test_api_error_inheritance
    assert_kind_of Nuntius::Error, Nuntius::APIError.new
  end

  def test_authentication_error_inheritance
    assert_kind_of Nuntius::Error, Nuntius::AuthenticationError.new
  end

  def test_rate_limit_error_inheritance
    assert_kind_of Nuntius::Error, Nuntius::RateLimitError.new
  end

  def test_invalid_request_error_inheritance
    assert_kind_of Nuntius::Error, Nuntius::InvalidRequestError.new
  end

  def test_network_error_inheritance
    assert_kind_of Nuntius::Error, Nuntius::NetworkError.new
  end

  def test_error_message
    message = 'Test error message'

    assert_equal message, Nuntius::Error.new(message).message
  end

  def test_api_error_message
    message = 'Test error message'

    assert_equal message, Nuntius::APIError.new(message).message
  end

  def test_authentication_error_message
    message = 'Test error message'

    assert_equal message, Nuntius::AuthenticationError.new(message).message
  end

  def test_rate_limit_error_message
    message = 'Test error message'

    assert_equal message, Nuntius::RateLimitError.new(message).message
  end

  def test_invalid_request_error_message
    message = 'Test error message'

    assert_equal message, Nuntius::InvalidRequestError.new(message).message
  end

  def test_network_error_message
    message = 'Test error message'

    assert_equal message, Nuntius::NetworkError.new(message).message
  end
end
