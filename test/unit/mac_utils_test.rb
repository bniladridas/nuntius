# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Palmshed

require 'test_helper'
require 'mac/mac_utils'

class MacUtilsTest < Minitest::Test
  def test_mac_detection
    skip "Test only runs on macOS" unless Nuntius::MacUtils.mac?
    assert Nuntius::MacUtils.mac?
  end

  def test_version_retrieval
    skip "Test only runs on macOS" unless Nuntius::MacUtils.mac?
    version = Nuntius::MacUtils.version
    assert version.is_a?(String)
    assert_match(/\d+\.\d+/, version)
  end
end
