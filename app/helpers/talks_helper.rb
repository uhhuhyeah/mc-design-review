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

  def post_to_ruby_dev(talk)
    presenters = talk.co_presenter ? "#{talk.presenter.name} and #{talk.co_presenter.name}" : talk.presenter.name
    to = Rails.env.production? ? 'rubydev@modcloth.com' : 'test@example.com'  
    subject = "#{truncate(talk.title, length: 30)} talk scheduled for #{date_format(talk.date)}"
    body = <<-DOC
      On #{date_format(talk.date)} #{presenters} will be giving a talk.
      %0D%0A
      %0D%0A
      Talk title: #{talk.title}
      "#{talk.description}"
      %0D%0A
      %0D%0A
      Who should attend?
      #{talk.attend}
      %0D%0A
      %0D%0A
      What can we expect to get from this talk?
      #{talk.expect}
      %0D%0A
      %0D%0A
      What should we do to prepare for this talk?
      #{talk.prepare}
      %0D%0A
      %0D%0A
      Link: #{talk_url(talk)}
    DOC

    "mailto:#{to}?subject=#{subject}&body=#{body}"
  end

  def talks_scope
    case params[:scope]
    when 'all'
      'All'
    when 'tbc'
      'To Be Decided'
    else
      'Recent'
    end
  end
end
