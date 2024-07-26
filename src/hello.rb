# frozen_string_literal: true

require 'json'

def handler(event:, context:)
  puts "Event: #{JSON.pretty_generate(event)}"
  puts "Context: #{JSON.pretty_generate(context)}"
end
