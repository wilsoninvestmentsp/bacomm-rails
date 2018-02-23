class Resource < ActiveRecord::Base
  mount_uploader :image, AssetUploader
  validates_presence_of :title, :message => "Please enter Title"
  validates_presence_of :link_name, :message => "Please enter Link Name"
  validates_presence_of :link_uri, :message => "Please enter Link URL"
  validates_format_of :link_uri, :with => /\A(http?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i, :message => "Please enter valid URL with http/https", if: Proc.new { |u| u.link_uri.present? }
end
