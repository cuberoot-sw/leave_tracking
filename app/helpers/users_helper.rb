module UsersHelper
  def options_for_bloodgroup(user)
    options_for_select([["A+", "A+"], ["A-", "A-"], ["B+", "B+"],
                        ["B-", "B-"], ["AB+", "AB+"], ["AB-", "AB-"],
                        ["O+", "O+"], ["O-", "O-"]],
                       :selected => user.blood_group
                      )
  end
end
