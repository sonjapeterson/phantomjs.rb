require 'spec_helper'

describe Phantomjs::Configuration do
  describe ".configure" do
    context "defaults" do
      it "sets a default path" do
        expect(Phantomjs::Configuration.phantomjs_path).to eq('phantomjs')
      end

      context "with custom settings" do
        before { Phantomjs.configure { |config| config.phantomjs_path = '/bin/phantomjs' } }

        it "sets a custom path" do
          expect(Phantomjs::Configuration.phantomjs_path).to eq('/bin/phantomjs')
        end
      end
    end
  end
end
