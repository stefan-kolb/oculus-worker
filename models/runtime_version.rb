require 'mongoid'

module Profiles
  class RuntimeVersion
    include Mongoid::Document

    field :name, type: String
    field :revision, type: DateTime
    field :version, type: String
    # validation
    validates :name, presence: true
    validates :revision, presence: true
    validates :version, presence: true #, format: { with: /http[s]?:\/\/.*/ }
  end
end