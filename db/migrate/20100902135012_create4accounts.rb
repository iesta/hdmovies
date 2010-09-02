class Create4accounts < ActiveRecord::Migration
  # lets create some accounts
  def self.up
    User.create(:username => "iesta", :email => "jm@iesta.com", :password => "tutututu", :password_confirmation => "tutututu")
    User.create(:username => "popcorn", :email => "greg@goemaere.com", :password => "poussin", :password_confirmation => "poussin")
    User.create(:username => "kryssix", :email => "chris@goemaere.com", :password => "kryssix", :password_confirmation => "kryssix")
    User.create(:username => "edlambi", :email => "ed.lambi@gmail.com", :password => "edlambi", :password_confirmation => "edlambi")
  end

  def self.down
  end
end
