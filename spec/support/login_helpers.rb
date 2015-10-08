module LoginHelpers
  def login(user)
    session[:user_id] = user.id
  end

  def login_as(user)
    post login_path, session: { email: user.email,
                                password: "password",
                                remember_me: "1" }
  end
end
