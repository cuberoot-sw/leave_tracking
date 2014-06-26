module HolidaysHelper
  def select_year_options(year)
    year_list = Setting.all.order('year DESC')
    options_from_collection_for_select(year_list, 'year', 'year', year)
  end
end
