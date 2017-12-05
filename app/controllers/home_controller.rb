class HomeController < ApplicationController
  before_action :set_params, only: [:index, :more_events]

  def index
    get_events(@params)
  end

  def more_events
    get_events(@params.merge(offset: params[:offset])) if params[:offset].present?
  end

  def get_events(params)
    @meetup_api = MeetupApi.new
    events = @meetup_api.events(params)
    binding.pry
    events(events)
  end

  def events(events)
    @events = events['results']
    if events['meta']['next'].present?
      url = events['meta']['next']
      uri = URI.parse(url)
      url_params = CGI.parse(uri.query)
      @next_page = url_params['offset'].first
    end
    
  end

  private

  def set_params
    @params = {
      group_urlname: 'BACOMM',
      scroll: 'future_or_past',
      status: 'upcoming,past', 
      format: 'json', 
      page: 3,
      desc: true,
      limited_events: true
    }
  end
end
