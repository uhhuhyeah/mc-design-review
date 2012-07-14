module ApplicationHelper
  include ActiveSupport::Inflector

  def date_format(time)
    parts = ['Thursday']
    parts << ordinalize(time.strftime('%d').to_i)
    parts << time.strftime('%B')
    parts.join(' ')
  end

end
