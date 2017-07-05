require 'rails_helper'

RSpec.describe AggregatedTransactionsReceivedMetric, type: :model do

  describe 'aggregates transactions received metric' do
    specify 'for a given department' do
      department = FactoryGirl.create(:department)

      service1 = FactoryGirl.create(:service, department: department)
      FactoryGirl.create(:transactions_received_metric, service: service1, starts_on: '2017-01-01', ends_on: '2017-01-31', channel: 'online', quantity: 100)
      FactoryGirl.create(:transactions_received_metric, service: service1, starts_on: '2017-02-01', ends_on: '2017-02-28', channel: 'online', quantity: 200)
      FactoryGirl.create(:transactions_received_metric, service: service1, starts_on: '2017-03-01', ends_on: '2017-03-31', channel: 'online', quantity: 300)
      FactoryGirl.create(:transactions_received_metric, service: service1, starts_on: '2017-01-01', ends_on: '2017-03-31', channel: 'phone', quantity: 500)

      service2 = FactoryGirl.create(:service, department: department)
      FactoryGirl.create(:transactions_received_metric, service: service2, starts_on: '2017-01-01', ends_on: '2017-01-31', channel: 'online', quantity: 100)
      FactoryGirl.create(:transactions_received_metric, service: service2, starts_on: '2017-02-01', ends_on: '2017-02-28', channel: 'online', quantity: 200)
      FactoryGirl.create(:transactions_received_metric, service: service2, starts_on: '2017-03-01', ends_on: '2017-03-31', channel: 'online', quantity: 300)
      FactoryGirl.create(:transactions_received_metric, service: service2, starts_on: '2017-01-01', ends_on: '2017-03-31', channel: 'phone', quantity: 500)

      # ignores metrics with overlapping ranges
      FactoryGirl.create(:transactions_received_metric, service: service1, starts_on: '2016-12-01', ends_on: '2017-01-31', channel: 'online', quantity: 65)
      FactoryGirl.create(:transactions_received_metric, service: service2, starts_on: '2017-02-01', ends_on: '2017-04-30', channel: 'online', quantity: 72)

      # ignores metrics for services, in other departments
      other_department=  FactoryGirl.create(:department)
      other_service = FactoryGirl.create(:service, department: other_department)
      FactoryGirl.create(:transactions_received_metric, service: other_service, starts_on: '2017-01-01', ends_on: '2017-01-31', channel: 'online', quantity: 95)

      time_period = instance_double(TimePeriod, starts_on: Date.parse('2017-01-01'), ends_on: Date.parse('2017-03-31'))
      metric = AggregatedTransactionsReceivedMetric.new(department, time_period)
      expect(metric.total).to eq(2200)
      expect(metric.online).to eq(1200)
      expect(metric.phone).to eq(1000)
      expect(metric.paper).to eq(0)
      expect(metric.face_to_face).to eq(0)
      expect(metric.other).to eq(0)
    end

    specify 'for a given agency' do
      agency = FactoryGirl.create(:agency)

      service1 = FactoryGirl.create(:service, agency: agency)
      FactoryGirl.create(:transactions_received_metric, service: service1, starts_on: '2017-01-01', ends_on: '2017-01-31', channel: 'online', quantity: 100)
      FactoryGirl.create(:transactions_received_metric, service: service1, starts_on: '2017-02-01', ends_on: '2017-02-28', channel: 'online', quantity: 200)
      FactoryGirl.create(:transactions_received_metric, service: service1, starts_on: '2017-03-01', ends_on: '2017-03-31', channel: 'online', quantity: 300)
      FactoryGirl.create(:transactions_received_metric, service: service1, starts_on: '2017-01-01', ends_on: '2017-03-31', channel: 'phone', quantity: 500)

      service2 = FactoryGirl.create(:service, agency: agency)
      FactoryGirl.create(:transactions_received_metric, service: service2, starts_on: '2017-01-01', ends_on: '2017-01-31', channel: 'online', quantity: 100)
      FactoryGirl.create(:transactions_received_metric, service: service2, starts_on: '2017-02-01', ends_on: '2017-02-28', channel: 'online', quantity: 200)
      FactoryGirl.create(:transactions_received_metric, service: service2, starts_on: '2017-03-01', ends_on: '2017-03-31', channel: 'online', quantity: 300)
      FactoryGirl.create(:transactions_received_metric, service: service2, starts_on: '2017-01-01', ends_on: '2017-03-31', channel: 'phone', quantity: 500)

      # ignores metrics with overlapping ranges
      FactoryGirl.create(:transactions_received_metric, service: service1, starts_on: '2016-12-01', ends_on: '2017-01-31', channel: 'online', quantity: 65)
      FactoryGirl.create(:transactions_received_metric, service: service2, starts_on: '2017-02-01', ends_on: '2017-04-30', channel: 'online', quantity: 72)

      # ignores metrics for services, in other agencies
      other_agency =  FactoryGirl.create(:agency)
      other_service = FactoryGirl.create(:service, agency: other_agency)
      FactoryGirl.create(:transactions_received_metric, service: other_service, starts_on: '2017-01-01', ends_on: '2017-01-31', channel: 'online', quantity: 95)

      time_period = instance_double(TimePeriod, starts_on: Date.parse('2017-01-01'), ends_on: Date.parse('2017-03-31'))
      metric = AggregatedTransactionsReceivedMetric.new(agency, time_period)
      expect(metric.total).to eq(2200)
      expect(metric.online).to eq(1200)
      expect(metric.phone).to eq(1000)
      expect(metric.paper).to eq(0)
      expect(metric.face_to_face).to eq(0)
      expect(metric.other).to eq(0)
    end

    specify 'for a given service' do
      service = FactoryGirl.create(:service)
      FactoryGirl.create(:transactions_received_metric, service: service, starts_on: '2017-01-01', ends_on: '2017-01-31', channel: 'online', quantity: 100)
      FactoryGirl.create(:transactions_received_metric, service: service, starts_on: '2017-02-01', ends_on: '2017-02-28', channel: 'online', quantity: 200)
      FactoryGirl.create(:transactions_received_metric, service: service, starts_on: '2017-03-01', ends_on: '2017-03-31', channel: 'online', quantity: 300)
      FactoryGirl.create(:transactions_received_metric, service: service, starts_on: '2017-01-01', ends_on: '2017-03-31', channel: 'phone', quantity: 500)

      # ignores metrics with overlapping ranges
      FactoryGirl.create(:transactions_received_metric, service: service, starts_on: '2016-12-01', ends_on: '2017-01-31', channel: 'online', quantity: 65)
      FactoryGirl.create(:transactions_received_metric, service: service, starts_on: '2017-02-01', ends_on: '2017-04-30', channel: 'online', quantity: 72)

      # ignores metrics for other services
      other_service = FactoryGirl.create(:service)
      FactoryGirl.create(:transactions_received_metric, service: other_service, starts_on: '2017-01-01', ends_on: '2017-01-31', channel: 'online', quantity: 95)

      time_period = instance_double(TimePeriod, starts_on: Date.parse('2017-01-01'), ends_on: Date.parse('2017-03-31'))
      metric = AggregatedTransactionsReceivedMetric.new(service, time_period)
      expect(metric.total).to eq(1100)
      expect(metric.online).to eq(600)
      expect(metric.phone).to eq(500)
      expect(metric.paper).to eq(0)
      expect(metric.face_to_face).to eq(0)
      expect(metric.other).to eq(0)
    end
  end

end