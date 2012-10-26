module TalksHelper

  def blog_post_link(url, disabled=false)
    button_link_helper(:blog, url, disabled) 
  end

  def slides_link(url, disabled=false)
   button_link_helper(:slides, url, disabled) 
  end

  def button_link_helper(type, url, disabled)
    icon_class, thing = case type
      when :blog
        ['icon-file', 'Blog Post']
      when :slides
        ['icon-picture', 'Slides']
      end
    
    btn_class = ['btn']
    btn_class << 'disabled' if disabled

    link_to content_tag(:i, '', class: icon_class) + " View #{thing}".html_safe, url, class: btn_class.join(' ')
  end

  def upcoming_fridays
    array_for_options = []
    (Time.now.to_date..6.weeks.from_now.to_date).each do |date|
      if date.wday == 5 # Friday
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
    when 'tbd'
      'To Be Decided'
    when 'mine'
      'My Talks'
    else
      'Recent'
    end
  end
end
