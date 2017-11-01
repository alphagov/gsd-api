class CallsReceivedMetricSerializer < ActiveModel::Serializer
  extend MetricSerializer

  attributes :type, :completeness

  metrics :total, :get_information, :chase_progress, :perform_transaction,
          :challenge_a_decision, :other, :sampled, :sampled_total

  def type
    'calls-received'
  end
end