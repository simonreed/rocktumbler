require 'spec_helper'

describe Rocktumbler::Group do
  let(:group_name) { :default }
  let(:opts) { OpenStruct.new(gem_info: true, gem_homepage: true) }
  let(:group) { Rocktumbler::Group.new(group_name, [1], opts) }
  let(:gem_mock) { instance_double('Rocktumbler::Gem') }

  before do
    allow_any_instance_of(Rocktumbler::Group).to(
      receive(:gems_from_dependencies) { [gem_mock] }
    )
    allow(gem_mock).to receive(:print) { 'gem \'example\'' }
  end

  describe '.print' do
    context ':default' do
      context 'specify gem version' do
        let(:group_string) do
          "\ngem 'example'"
        end

        it 'should have no prepend' do
          expect(gem_mock).to receive(:print).with('')
          group.print
        end
        specify { expect(group.print).to eq(group_string) }
      end
    end
    context 'with group name other than :default' do
      context 'specify gem version' do
        let(:group_name) { :development }
        let(:group_string) do
          "\n\ngroup development do\ngem 'example'\nend\n"
        end

        it 'should have no prepend' do
          expect(gem_mock).to receive(:print).with('  ')
          group.print
        end
        specify { expect(group.print).to eq(group_string) }
      end
    end
  end
end
