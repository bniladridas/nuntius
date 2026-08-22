# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Palmshed

# frozen_string_literal: true

require 'test_helper'

class ModerationTest < Minitest::Test
  def test_moderate_clean_text
    text = "This is a safe response with no issues"
    moderated, warnings = Nuntius::Utils::Moderation.moderate_text(text)

    assert_equal text, moderated
    assert_empty warnings
  end

  def test_moderate_single_harmful_word
    moderated, warnings = Nuntius::Utils::Moderation.moderate_text("This system could be exploited easily")

    assert_equal "This system could be [REDACTED]ed easily", moderated
    assert_equal 1, warnings.size
    assert_match(/exploit/, warnings.first)
  end

  def test_moderate_case_insensitive
    moderated, warnings = Nuntius::Utils::Moderation.moderate_text("Learn to HACK and EXPLOIT systems")

    assert_equal "Learn to [REDACTED] and [REDACTED] systems", moderated
    assert_equal 1, warnings.size
  end

  def test_moderate_multiple_patterns
    text = "You can hack this system or exploit vulnerabilities with malware"
    moderated, warnings = Nuntius::Utils::Moderation.moderate_text(text)

    assert_equal "You can [REDACTED] this system or [REDACTED] vulnerabilities with [REDACTED]", moderated
    assert_equal 1, warnings.size
  end

  def test_moderate_non_string
    moderated, warnings = Nuntius::Utils::Moderation.moderate_text(nil)

    assert_nil moderated
    assert_empty warnings
  end

  def test_moderate_empty_string
    moderated, warnings = Nuntius::Utils::Moderation.moderate_text("")

    assert_equal "", moderated
    assert_empty warnings
  end
end
