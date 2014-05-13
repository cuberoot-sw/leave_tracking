module UsersHelper
  def options_for_post_bloodgroup
    options_for_select([["A+", "A+"], ["A-", "A-"], ["B+", "B+"],
                        ["B-", "B-"], ["AB+", "AB+"], ["AB-", "AB-"],
                        ["O+", "O+"], ["O-", "O-"]])
  end
end
