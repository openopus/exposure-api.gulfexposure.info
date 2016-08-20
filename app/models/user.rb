class User < ApplicationRecord
  before_save :unique_codename

  def self.generate_codename
    self.new.generate_codename
  end
  
  def generate_codename
    Haikunator.haikunate(0).split('-').map(&:capitalize).join("")
  end

  def unique_codename
    if not self.codename
      candidate = self.generate_codename
      while self.class.where(codename: candidate).first != nil
        candidate = self.generate_codename
      end
      self.codename = candidate
    end
  end
end
