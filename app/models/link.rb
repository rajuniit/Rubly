class Link < ActiveRecord::Base

  has_many :views

  validates_presence_of :long_url, :ip_address
  validates_uniqueness_of :long_url, :short_url
  validates_format_of :long_url, :with => /^(http):\/\/[a-z0-9]/ix, :on => :save, :message => 'Invalid url'

  before_create :generate_short_url



  def get_link_by_slug(slug)
    Link.find_by_slug(slug)
  end

  def update_views(request)

    view = views.build(:ip_address => request.remote_ip, :referer => request.referer,
                       :browser => request.user_agent)
    view.save

  end


  private

    def generate_short_url
      generate_slug
      self.short_url = BASE_URL + self.slug
    end

   def generate_slug
       slug_string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-'
       slug = ''
       5.times do
         index = rand(slug_string.length);
         slug += slug_string[index..index]
       end
       if is_slug_available(slug)
          generate_slug
       end
       self.slug = slug
   end

   def is_slug_available(slug)
       @link = Link.find_by_slug(slug)
       if @link.nil?
         return false
       else
         return true
       end
   end


end
