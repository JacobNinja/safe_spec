$:.unshift(File.dirname(__FILE__) + "/..")

class MockObject

  def test(*args)
  end

end

describe "safe_*" do

  context "with rspec mock" do
    load('rspec_safe_spec_monkeypatch.rb')

    let(:sut) { MockObject.new }

    context "raises NoMethodError on" do
      it "stub" do
        lambda { sut.safe_stub(:invalid_method) }.should raise_error(NoMethodError)
      end
      it "should_receive" do
        lambda { sut.safe_should_receive(:invalid_method) }.should raise_error(NoMethodError)
      end
      it "verifies multiple stubs within a hash" do
        lambda { sut.safe_stub({:test => 'hello', :invalid_method => 'world'}) }.should raise_error(NoMethodError)
      end
    end

    context "delegation" do
      let(:test_method) { :test }

      it "delegates to stub" do
        sut.should_receive(:stub).with(test_method)
        sut.safe_stub(test_method)
      end

      it "delegates to should_receive" do
        sut.should_receive(:should_receive).with(test_method)
        sut.safe_should_receive(test_method)
      end
    end

    context "real behavior" do
      it "test expectations" do
        sut.safe_should_receive(:test).with("argument").and_return(:return_value)
        sut.test("argument").should == :return_value
      end
    end
  end
end