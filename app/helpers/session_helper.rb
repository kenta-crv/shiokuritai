module SessionHelper
  def correct_user?(user)
    user == current_user
  end

  def correct_company?(company)
    company == current_company
  end
end
