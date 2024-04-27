module Counter
  extend ActiveSupport::Concern
  class_methods do
    def public_count
      where(@task).count
    end
  end
end
