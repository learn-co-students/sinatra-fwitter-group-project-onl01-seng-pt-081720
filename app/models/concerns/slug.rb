module Slug
    def slug
        slug = (self.username).downcase.strip.split(" ")
        slug = slug.join("-")
        slug
    end
end