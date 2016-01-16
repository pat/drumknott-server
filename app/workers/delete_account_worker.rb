class DeleteAccountWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find user_id
    user.sites.each do |site|
      Payments::Cancel.call site
      site.destroy
    end

    user.destroy
    UserMailer.deleted(user.email).deliver_now
  end
end
