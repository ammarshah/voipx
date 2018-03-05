class Admin::ActivitiesController < AdminController
    def index
        @sign_ins = PaperTrail::Version.where(item_type: 'User').order(created_at: :desc)
        @routes = PaperTrail::Version.where(item_type: 'Route').order(created_at: :desc)
        @messages = PaperTrail::Version.where(item_type: 'Mailboxer::Conversation').order(created_at: :desc)
        @searches = PaperTrail::Version.where(item_type: 'Search').order(created_at: :desc)
    end
end