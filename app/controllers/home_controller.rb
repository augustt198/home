class HomeController < ApplicationController

  def index

  end

  def new_link
    url = nil
    begin
      url = URI.parse(params[:shortened_link][:redirect])
    rescue URI::InvalidURIError
    end
    @good_url = url.is_a? URI::HTTP

    if @good_url
      @shortened_link = ShortenedLink.new
      @shortened_link.redirect = params[:shortened_link][:redirect]
      @shortened_link.shortened = ShortenedLink.generate_shortened_name
      @shortened_link.created_at = Time.now
      @shortened_link.save!

      link = request.host + '/l/' + @shortened_link.shortened
      @link_preview = "<a href=\"http://#{link}\">#{link}</a>".html_safe
      @copy_html = '<button id="copy-button" class="btn btn-info btn-xs" ' + "data-clipboard-text=\"http://#{link}\"" + '><i class="fa fa-clipboard"></i></button>'
      @copy_html = @copy_html.html_safe
    end
  end

  def link_redirect
    shortened = ShortenedLink.where(shortened: params[:id]).first
    raise ActionController::RoutingError.new('Not Found') unless shortened
    redirect_to shortened.redirect
    shortened.views += 1
    shortened.save!
  end

end
