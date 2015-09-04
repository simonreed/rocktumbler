require 'spec_helper'

describe Rocktumbler::Gem do
  let(:gem_name) { 'bundler' }
  let(:gem_summary) { 'Bundler summary' }
  let(:gem_homepage) { 'bundler.io' }
  let(:opts) { OpenStruct.new(docs: true) }
  before do
    Bundler.stub_chain(:definition, :specs)
      .and_return([OpenStruct.new(name: gem_name,
                                  summary: gem_summary,
                                  homepage: gem_homepage
                                 )])
  end
  describe '.print' do
    context 'gem version' do
      context 'specify gem version' do
        let(:gem_version) { '0.1.0' }
        let(:dependency) { Bundler::Dependency.new(gem_name, gem_version) }
        let(:gem) { Rocktumbler::Gem.new(dependency, opts) }
        let(:gem_string) do
          "# #{gem_summary}\n# #{gem_homepage}\n\gem '#{gem_name}', '= \
#{gem_version}'"
        end
        specify { expect(gem.print).to eq(gem_string) }
      end
      context 'no gem version specified' do
        let(:gem_version) { nil }
        let(:dependency) { Bundler::Dependency.new(gem_name, gem_version) }
        let(:gem) { Rocktumbler::Gem.new(dependency, opts) }
        let(:gem_string) do
          "# #{gem_summary}\n# #{gem_homepage}\ngem '#{gem_name}'"
        end
        specify { expect(gem.print).to eq(gem_string) }
      end
    end
    context ':require' do
      context 'true' do
        let(:dependency) do
          Bundler::Dependency.new(gem_name,
                                  nil,
                                  'require' => true
                                 )
        end
        let(:gem) { Rocktumbler::Gem.new(dependency, opts) }
        let(:gem_string) do
          "# #{gem_summary}\n# #{gem_homepage}\ngem \
'#{gem_name}', require: true"
        end
        specify { expect(gem.print).to eq(gem_string) }
      end
      context 'false' do
        let(:dependency) do
          Bundler::Dependency.new(gem_name,
                                  nil,
                                  'require' => false
                                 )
        end
        let(:gem) { Rocktumbler::Gem.new(dependency, opts) }
        let(:gem_string) do
          "# #{gem_summary}\n# #{gem_homepage}\ngem \
'#{gem_name}', require: false"
        end
        specify { expect(gem.print).to eq(gem_string) }
      end
      context 'string' do
        let(:dependency) do
          Bundler::Dependency.new(gem_name,
                                  nil,
                                  'require' => 'bunder/test'
                                 )
        end
        let(:gem) { Rocktumbler::Gem.new(dependency, opts) }
        let(:gem_string) do
          "# #{gem_summary}\n# #{gem_homepage}\ngem \
'#{gem_name}', require: 'bunder/test'"
        end
        specify { expect(gem.print).to eq(gem_string) }
      end
      context 'array of strings' do
        let(:dependency) do
          Bundler::Dependency.new(gem_name,
                                  nil,
                                  'require' => ['bunder/test', 'bundler']
                                 )
        end
        let(:gem) { Rocktumbler::Gem.new(dependency, opts) }
        let(:gem_string) do
          "# #{gem_summary}\n# #{gem_homepage}\ngem \
'#{gem_name}', require: ['bunder/test', 'bundler']"
        end
        specify { expect(gem.print).to eq(gem_string) }
      end
    end
  end
end
