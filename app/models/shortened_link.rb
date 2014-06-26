# A shortened link

class ShortenedLink

  include Mongoid::Document

  field :created_at, type: Time

  field :shortened, type: String
  field :redirect, type: String

  field :views, type: Integer, default: 0

  def self.generate_shortened_name
    (0...5).map { (65 + rand(26)).chr }.join.downcase
  end

end
