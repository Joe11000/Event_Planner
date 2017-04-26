require_relative '../lib/run'
require_relative './spec_helper'
require 'pry'

RSpec.shared_examples 'Preparable Role(aka Duct Type)' do
  it '@preparer' do
    expect(Package.instance_methods).to include(:default_num_of_people)
  end
end

RSpec.shared_examples 'A package' do
  it_behaves_like 'Preparable Role(aka Duct Type)'

  context 'inherits' do
    let(:cost_per_person) { 2.22 }
    let(:num_of_people) { 2 }
    let(:package) { Package.new({num_of_people: num_of_people, cost_per_person: cost_per_person}) }

    it '@num_of_people' do
      expect(package.num_of_people).to eq num_of_people
    end

    it '@managers_name' do
      expect(package.managers_name).to eq nil
    end

    it '@cost' do
      expect(package.cost).to eq (cost_per_person * num_of_people)
    end

    it 'Specialization hook, @default_num_of_people, exists as a public method' do
      expect(Package.instance_methods).to include(:default_num_of_people)
    end
    it 'Specialization hook, @default_cost_per_person, exists as a public method' do
      expect(Package.instance_methods).to include(:default_cost_per_person)
    end
  end
end

RSpec.describe Package, 'is an abstract superclass' do
  it_behaves_like 'A package'

  context 'whose subclass' do

    context 'throws an error if' do
      it 'no args[:num_of_people] and default_num_of_people implemented' do
        expect {
          Package.new({cost_per_person: 1})
        }.to raise_error(NotImplementedError)
      end

      it 'no args[:cost_per_person] and default_cost_per_person implemented' do
        expect {
          Package.new({num_of_people: 1})
        }.to raise_error(NotImplementedError)
      end
    end
  end
end

RSpec.describe OnlineExperience do
  it_behaves_like 'A package'

  context 'instance' do
    context 'methods' do
      it '@location' do
        expect(OnlineExperience.new({event_ip_address: '127.0.0.1'}))
      end

      it '@event_ip_address' do
        expect(OnlineExperience.new({event_ip_address: '127.0.0.1'}))
      end

      it '@default_num_of_people' do
        expect(EventExperience.new({event_ip_address: '127.0.0.1'}).default_num_of_people).to eq 10
      end

      it '@default_cost_per_person' do
        expect(EventExperience.new({event_ip_address: '127.0.0.1'}).default_cost_per_person).to eq 25
      end
    end
  end
end

RSpec.describe EventExperience, 'is an abstract superclass' do
  it_behaves_like 'A package'
end
