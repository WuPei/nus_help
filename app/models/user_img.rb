class UserImg < ActiveRecord::Base
  attr_accessible :origin,:cropped,:cx,:cy,:cw,:ch

  PathFormat = "uploads/user_img/%d/";
  OriginName = "origin";
  ThumbnailName = "cropped";
  DefaultCroppedUrl = "/uploads/user_img/default_crop.jpg";

  belongs_to :user
  
  validates :user_id, presence: true 

  def save_upload(field)
    publicPath = "%s%s%s" % 
                 [PathFormat % self.user_id, OriginName, File.extname(field.original_filename)]
    filepath = "public/" + publicPath
    FileUtils.mkpath (File.dirname filepath),{mode:0755}
    FileUtils.copy(field.tempfile, filepath)
    File.chmod(0755,filepath)
    self.origin = publicPath
    self.save!
  end

  def origin_name
    if self.origin.nil?
      "/error"
    else
      "/" + self.origin
    end
  end

  def save_croping(u)
    x,y,w,h = u[:cx].to_f.round,u[:cy].to_f.round,u[:cw].to_f.round,u[:ch].to_f.round
    self.cx,self.cy,self.cw,self.ch = x,y,w,h

    origin_path = self.origin_filepath
    img = MiniMagick::Image.open(origin_path)
    img.crop("#{w}x#{h}+#{x}+#{y}")
    # Save it to temp path
    smaSave = File.dirname(self.origin) + "/" + ThumbnailName + File.extname(self.origin)
    smaFilePath = "public/" + smaSave;

    img.resize "180x180"
    img.write smaFilePath
    File.chmod(0755,smaFilePath)
    self.cropped = smaSave
    self.save!
  end

  class <<self
    def cropFields?(u)
      !u.nil? and !u[:cx].blank? and !u[:cy].blank?  and !u[:cw].blank? and !u[:ch].blank?
    end
  end

  def origin_filepath
    if self.origin.nil?
      nil
    else
      "public/" + self.origin
    end
  end

  def cropped_url
    if self.cropped.nil?
      nil
    else
      "/" + self.cropped_path
    end
  end

  def crop_data_str 
    if(self.cx.nil?)
      "0 0 180 180"
    else
      "%d %d %d %d" % [self.cx,self.cy,self.cw,self.ch]
    end
  end

end
