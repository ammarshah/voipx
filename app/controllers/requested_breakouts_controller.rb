class RequestedBreakoutsController < ApplicationController
    before_action :authenticate_user!

    def create
        @requested_breakout = RequestedBreakout.new(requested_breakout_params)

        respond_to do |format|
            if @requested_breakout.save
                format.js
            else
                format.js
            end
        end
      end
    
    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def requested_breakout_params
            params.require(:requested_breakout).permit(:destination, :breakout, :user_id)
        end
    
end