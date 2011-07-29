class LinksController < ApplicationController

  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end


  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
    end
  end


  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end


  def create
    @link = Link.new(params[:link])
    @link.ip_address = request.remote_ip
    respond_to do |format|
      if @link.save
        format.html { redirect_to(@link, :notice => 'Link was successfully created.') }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  def render_link
    slug = params[:slug]
    @link = Link.new
    @link = @link.get_link_by_slug(slug)
     respond_to do |format|
      if @link.nil?
        format.html {redirect_to(@link, :notice => 'Invalid Link')}
      else

        @link.update_views(request)
        format.html {redirect_to(@link.long_url, :status => 301)}
      end
     end

  end

end
