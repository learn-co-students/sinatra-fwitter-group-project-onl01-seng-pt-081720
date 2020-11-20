module FindBySlug

        def find_by_slug(name)
            res = name.split("-").join(" ")
            res4 = self.find_by(username: res)
        end

end