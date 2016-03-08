class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.blank?
      begin
        u = URI(value)
        record.errors[attribute] << '- the value must begin with a scheme (http:// or https://).' unless u.host && u.scheme
        unless u.scheme == 'http' or u.scheme == 'https'
          record.errors[attribute] << '- the value must begin with http:// or https://.'
        end
      rescue => e
        record.errors[attribute] << '- the value is invalid. An acceptable URL matches this format: https://example.com.'
      end
    else
      record.errors[attribute] << 'is required.'
    end
  end
end
