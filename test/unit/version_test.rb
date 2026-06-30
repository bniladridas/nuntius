# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Palmshed

# frozen_string_literal: true

require 'test_helper'

class VersionTest < Minitest::Test
  def test_version
    refute_nil Nuntius::VERSION
    assert_match(/\d+\.\d+\.\d+/, Nuntius::VERSION)
  end
end
