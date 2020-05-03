class Seeds::User
  def initialize(email: 'me@mikerogers.io', name: 'PigCI', installs: [Install.last])
    @email = email
    @name = name
    @installs = installs
  end

  def save!
    ::User.find_or_create_by!(email: @email) do |user|
      user.name = @name
      user.password = '12345678'
      user.password_confirmation = '12345678'
      user.installs = @installs
    end
  end
end
