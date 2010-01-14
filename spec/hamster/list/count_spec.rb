require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

require 'hamster/list'

describe Hamster::List do

  describe "#count" do

    it "is lazy" do
      lambda { Hamster.stream { false }.count { false } }.should_not raise_error
    end

    [
      [[], 0],
      [[1], 1],
      [[1, 2], 1],
      [[1, 2, 3], 2],
      [[1, 2, 3, 4], 2],
      [[1, 2, 3, 4, 5], 3],
    ].each do |values, expected|

      describe "on #{values.inspect}" do

        before do
          @original = Hamster.list(*values)
        end

        describe "with a block" do

          before do
            @result = @original.count(&:odd?)
          end

          it "returns #{expected.inspect}" do
            @result.should == expected
          end

        end

        describe "without a block" do

          before do
            @result = @original.count
          end

          it "returns length" do
            @result.should == @original.length
          end

        end

      end

    end

  end

end
