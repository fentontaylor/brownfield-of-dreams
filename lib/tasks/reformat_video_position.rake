# frozen_string_literal: true

namespace :video do
  desc 'Replace all nil values in position column with 0'

  task change_nil_to_0: :environment do
    Video.where(position: nil).each do |v|
      v.update(position: 0)
    end
  end
end
