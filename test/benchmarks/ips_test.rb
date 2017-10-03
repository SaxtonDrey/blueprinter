require_relative '../test_helper'
require_relative 'benchmark_helper'
require 'ostruct'

class Blueprinter::IPSTest < Minitest::Test
  include BenchmarkHelper

  def setup
    @blueprinter = Class.new(Blueprinter::Base) do
      field :id
      field :name
    end
    @prepared_objects = 10.times.map {|i| OpenStruct.new(id: i, name: "obj #{i}")}
  end

  def test_render
    result = iterate {@blueprinter.render(@prepared_objects)}
    puts "\nBasic IPS: #{result}"
    assert_operator(result, :>=, 3000)
  end
end
