class Promocao < ApplicationRecord
  belongs_to :upsell
  has_many :item_promocoes, :dependent => :delete_all

  default_scope { order(created_at: :asc) }

  def promocao_se_pago_vai_para
  	Promocao.where(id: self.se_pago_vai_para).first
  end

  def promocao_se_negou_vai_para
  	Promocao.where(id: self.se_negou_vai_para).first
  end

  def video_embed
    return "" if self.video.blank?
    return self.video.include?("youtube") ? "https://www.youtube.com/embed/#{self.video.split("=").second}?showinfo=0" : "https://player.vimeo.com/video/#{self.video.split("/").last}"
  end
end
