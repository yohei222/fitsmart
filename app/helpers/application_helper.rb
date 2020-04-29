module ApplicationHelper

  def full_title(page_title)
    base_title = "Fit Smart"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def user_signin_error(user)
    errors = user.errors.full_messages.uniq
    if user.email.empty?
      errors.delete("Eメールは不正な値です")
    else
      errors.delete("Eメールを入力してください")
    end
    if user.password_digest.nil?
      errors.delete("パスワードは6文字以上で入力してください")
    else
      errors.delete("パスワードを入力してください")
    end
    if errors.include?("Password confirmationとパスワードの入力が一致しません")
      errors.delete("Password confirmationとパスワードの入力が一致しません")
      errors << "パスワードと再確認用パスワードが一致していません"
    end
    return errors
  end

  def sr(exercise)
    exercise.sort.reverse
  end

end