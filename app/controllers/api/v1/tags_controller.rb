module Api
  module V1
    class TagsController < ApplicationController

      def index 
        tags = Tag.order(created_at: :desc)
        render status:200, json: tags
      end
    
      def create
        tag = Tag.new(tag_params)
        tag.save!
        render status:201, json: tag
      end

      def search
        search = sanitize_sql_like(params[:search])
        tags = Tag.where('name LIKE ?', "%#{search}%")
        render status: 200, json: tags
      end
        
      def destroy
        tag = Tag.find(params[:id])
        tag.destroy!
        render status: 204, json: { message: 'Deleted the Tag' }        
      end

      private

      def sanitize_sql_like(string, escape_character = "\\")
        pattern = Regexp.union(escape_character, "%", "_")
        string.gsub(pattern) { |x| [escape_character, x].join }
      end

      def tag_params
        params.require(:tag).permit(:name)
      end
    
    end
  end
end

