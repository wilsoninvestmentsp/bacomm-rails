class HomeController < ApplicationController
  before_action :set_params, only: [:index, :more_events]

  #caches_action :index, expires_in: 7.days
  def index
    api_token = ApiToken.find_by(platform: 'meetup')
    begin
      if api_token.present? && params[:events].present?
        if api_token.expire_on > Time.now
          state = params[:events]
          next_month_end_date = state == 'upcoming' ? "&no_later_than=#{end_date_of_next_month}" : ''
          events = RestClient.get "https://api.meetup.com/#{Settings.meetup.group_urlname}/events?status=#{state}&fields=featured_photo#{next_month_end_date}", headers: { "Authorization" => "Bearer #{api_token.access_token}"}
        else
          # TODO fetch new access token using refresh token
          access_response = RestClient.post Settings.meetup.OAuth_api_end_point, {client_id: MEETUP_API_KEY, client_secret: MEETUP_API_SECRET, grant_type: 'refresh_token', refresh_token: api_token.refresh_token}
        end
        @events = JSON.parse(events) rescue []
      end

      respond_to do |format|
        format.js
        format.html
      end
    rescue Exception => e
      Rails.logger.error "Error: #{e.message} - #{e.backtrace.join('\n')}"
      flash[:danger] = "Something went wrong. Please try after sometime"
      redirect_to root_path
    end
  end

  def more_events
    get_events(@meetup_params.merge(offset: params[:offset])) if params[:offset].present?
  end

  def connect_with_meetup
  end

  def get_events(meetup_params)
    begin
      events = MeetupApi.new.events(meetup_params)
      events(events)
    rescue JSON::ParserError
      retry
    end
  end

  def events(events)
    @events = events['results']
    if @events.present? && events['meta']['next'].present?
      url = events['meta']['next']
      uri = URI.parse(url)
      url_params = CGI.parse(uri.query)
      @next_page = url_params['offset'].first
    end
  end

  private

  def set_params
    @meetup_params = {
      group_urlname: Settings.meetup.group_urlname,
      format: 'json',
      page: Settings.meetup.per_page
    }
    @meetup_params[:status] = params[:events] if params[:events].present?
    @meetup_params[:desc] = true if params[:events] == 'past'
  end

  def end_date_of_next_month
    (Time.now + 2.month).end_of_month.strftime('%Y-%m-%dT00:00:00')
  end
end
