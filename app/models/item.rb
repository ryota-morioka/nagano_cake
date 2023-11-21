class Item < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :introduction, presence: true

  has_one_attached :image

  def generate_variant_image(width, height)
  # 画像をリサイズして変種を生成
    if image.attached?
      image.variant(resize_to_fill: [width, height], gravity: :center).processed
    else
      # 画像が添付されていない場合のデフォルト処理
      default_image = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(default_image), filename: "default-image.jpg", content_type: "image/jpeg")
      image.variant(resize_to_fill: [width, height], gravity: :center).processed
    end
  end
  def with_tax_price
    tax = 1.1
    (price * tax).floor
  end

  def self.search(search)
    return Item.all unless search
    Item.where(['name LIKE ?', "%#{search}%"])
  end

end
