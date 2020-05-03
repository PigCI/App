class Seeds::Install
  def save!
    ::Install.find_or_create_by!(
      account_login: 'PigCI',
      app_id: 22929,
      install_id: 875537
    )
  end
end
