# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
    identifier :id

    # association method to serialize the posts association.
    
    #association :posts, blueprint: PostBlueprint, view: :normal

    #block will be used to filter the posts
    association :posts, blueprint: PostBlueprint, view: :normal do |user| user.posts.first
    end
    
    view :normal do
        fields :username
    end

    view :extended do
        fields :username, :created_at, :updated_at
    end
end
