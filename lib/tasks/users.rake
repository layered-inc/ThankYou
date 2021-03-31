# $ rake users:convert

namespace :users do
  desc 'アーカイブ重複問題'

  task convert: :environment do
    mail_sets = [
      %w[],
    ]

    mail_sets.each do |mail_set|
      mail_form, mail_to = mail_set[0], mail_set[1]

      user_form = User.find_by(email: mail_form)
      user_to = User.find_by(email: mail_to)

      next unless user_form.present? && user_to.present?

      Message.where(sender_id: user_form.id).update_all(sender_id: user_to.id)
      Message.where(recipient_id: user_form.id).update_all(recipient_id: user_to.id)

      user_form.destroy
    end
  end
end
