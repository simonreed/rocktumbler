require 'spec_helper'

describe Rocktumbler::Gem do
  let(:gem_name) { 'bundler' }
  let(:gem_version) { '' }
  let(:gem_summary) { 'Bundler summary' }
  let(:gem_homepage) { 'bundler.io' }
  before { Bundler.stub_chain(:definition,:specs).and_return([OpenStruct.new(name: gem_name, summary: gem_summary, homepage: gem_homepage)]) }
  describe ".print" do
    context "specify gem version" do
      let(:gem_version) { '0.1.0' }
      let(:dependency) { Bundler::Dependency.new(gem_name,gem_version)}
      let(:gem) { Rocktumbler::Gem.new(dependency)}
      let(:gem_string) { "# #{gem_summary}\n# #{gem_homepage}\ngem '#{gem_name}','= #{gem_version}'\n\n"}
      specify { expect(gem.print).to eq(gem_string) }
    end
  end
end