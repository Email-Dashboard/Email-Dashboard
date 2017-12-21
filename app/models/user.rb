class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :invitable, :invite_for => 2.weeks

   has_many :account_users
   has_many :accounts, through: :account_users

   def setup_account(name)
     account = Account.create(name: name)
     account_users.create!(account: account, role: 'owner')
   end

   def role_in_account(account)
     account_users.where(account: account).first.role
   end
end
