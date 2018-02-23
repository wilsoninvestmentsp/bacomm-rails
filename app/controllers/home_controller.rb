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
    events(events)
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
    @params = {
      group_urlname: Settings.meetup.group_urlname,
      format: 'json',
      page: Settings.meetup.per_page
    }
  end
end
