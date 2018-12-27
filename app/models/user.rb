class User < ApplicationRecord
  authenticates_with_sorcery!
  rolify
end
