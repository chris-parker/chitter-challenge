class User
  include DataMapper::Resource

  property :id, Serial
  property :content, Text, :lazy => false, :required => true

  belongs_to :user

end
