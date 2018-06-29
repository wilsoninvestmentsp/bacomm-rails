class Resource < ActiveRecord::Base
  mount_uploader :image, AssetUploader
  validates_presence_of :title, :message => "Please enter Title"
  validates_presence_of :link_name, :message => "Please enter Link Name"
  validates_presence_of :link_uri, :message => "Please enter Link URL"
  validates_format_of :link_uri, with: %r{\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,63}(:[0-9]{1,5})?(\/.*)?\z}ix, message: 'Please enter valid URL with http/https', if: Proc.new { |u| u.link_uri.present? }

  scope :latest, -> { order(:created_at, :desc) }
end
