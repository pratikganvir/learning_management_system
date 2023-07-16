class Login < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :loginable, polymorphic: true

  def method_missing(symbol, *args)
    loginable_type_cls = symbol.id2name.gsub('?','').capitalize
    if loginable_type == loginable_type_cls
       true
    elsif Login.distinct.pluck(:loginable_type).include?(loginable_type_cls)
      false
    else
       super(symbol, *args)
    end
  end
end
