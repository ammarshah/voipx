class CreatePlansService
  def call
    Plan.delete_all
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE plans_id_seq RESTART WITH 1")

    Plan.create([
      {
        name: 'Basic',
        description: 'Basic plan does not allow you unlimited access to your VoIPx account.',
        paypal_description: 'Basic plan does not allow you unlimited access to your VoIPx account.',
        price: 0
      },
      {
        name: 'Pro',
        description: 'Pro plan gives you unlimited access to your VoIPx account.',
        paypal_description: 'Pro plan gives you unlimited access to your VoIPx account.',
        price: 25
      }
    ])

    Plan.all.collect { |plan| plan.name }
  end
end
