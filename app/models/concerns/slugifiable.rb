module Slugifiable
  module InstanceMethods
    def slug
      username.parameterize
    end
  end
  module ClassMethods
    def find_by_slug(slug)
      # is there a better way to do this?
      self.all.detect {|i| i.username.parameterize == slug}
    end
  end
end