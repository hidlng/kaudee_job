class WelcomeController < DefaultController
  #layout "application", except: [:policy, :password]

  def index
    @cars = Job.count
    @users = User.count
  end

  def policy
  end

  def password
  end

  def test
  end
end
