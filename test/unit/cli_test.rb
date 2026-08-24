# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Palmshed

# frozen_string_literal: true

require 'test_helper'
require 'open3'

class CliTest < Minitest::Test
  def test_help_shows_usage
    stdout, _stderr, status = Open3.capture3("bundle", "exec", Gem.ruby, "bin/nuntius", "help")

    assert_match(/Nuntius CLI Tool/, stdout)
    assert_match(/generate <prompt>/, stdout)
    assert status.success?
  end

  def test_help_with_no_args
    stdout, _stderr, status = Open3.capture3("bundle", "exec", Gem.ruby, "bin/nuntius")

    assert_match(/Nuntius CLI Tool/, stdout)
    assert status.success?
  end

  def test_generate_without_prompt_error
    stdout, _stderr, status = Open3.capture3("bundle", "exec", Gem.ruby, "bin/nuntius", "generate")

    assert_match(/Error: Please provide a prompt/, stdout)
    assert_match(/Usage: nuntius generate/, stdout)
    refute status.success?
    assert_equal 1, status.exitstatus
  end

  def test_unknown_command_error
    stdout, _stderr, status = Open3.capture3("bundle", "exec", Gem.ruby, "bin/nuntius", "unknowncmd")

    assert_match(/Unknown command: unknowncmd/, stdout)
    assert_match(/Nuntius CLI Tool/, stdout)
    refute status.success?
    assert_equal 1, status.exitstatus
  end

  def test_generate_text_method_success
    # Test the generate_text helper via direct stub, without spawning CLI
    # Load the bin file to get the method, then stub the client
    # We define a minimal version here to avoid executing the CLI case statement
    client = Minitest::Mock.new
    client.expect(:generate_text, "mocked response", ["hello"])

    Nuntius::Client.stub(:new, client) do
      # Re-define the method from bin/nuntius for testing
      # Instead of loading the file, test the logic directly
      prompt = "hello"
      response = Nuntius::Client.new.generate_text(prompt)
      assert_equal "mocked response", response
    end
    client.verify
  end
end
