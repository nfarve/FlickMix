def getCurrentUser
    @current_user ||= User.get(session[:user_id]) if session[:user_id]end


def loginUser(user)
    session[:user_id] = user.id
end