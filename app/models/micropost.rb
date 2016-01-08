class Micropost < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id,presence:true
  validates :content,presence:true,length:{maximum:140}
  validate :picture_size

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture,"picture Should be less than 5 MB")
      end
    end
end
