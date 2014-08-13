class CastMembersController < ApplicationController
	
	def show_by_name
		@actor = CastMember.find_by full_name: params[:full_name]
	end
	
	def index
		@actors = CastMember.all
	end
end