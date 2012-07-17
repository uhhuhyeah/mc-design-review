module TalksHelper

  def upcoming_thursdays
    array_for_options = []
    (Time.now.to_date..6.weeks.from_now.to_date).each do |date|
      if date.wday == 4 # Thursday
        array_for_options << [date_format(date), date]
      end
    end
    array_for_options
  end

  # File actionpack/lib/action_view/helpers/text_helper.rb, line 198
  def pluralize(count, singular, plural = nil)
    "#{count || 0} " + (count == 1 ? singular : (plural || singular.pluralize))
  end

end
