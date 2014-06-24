module ApplicationHelper
  def holidays_link
    setting = Setting.where(year:Time.now.year).first
    setting_id = setting.present? ? setting.id : nil
    url = setting_id.present? ? "/settings/#{setting_id}/holidays" : "#"
    link_to "Holidays", url
  end
end
