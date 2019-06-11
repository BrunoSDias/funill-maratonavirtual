class ItemPromocao < ApplicationRecord
  belongs_to :promocao

  def video_embed
    return "" if self.video.blank?
    return "https://www.youtube.com/embed/#{self.video.split("=").second}?showinfo=0"
  end
end
