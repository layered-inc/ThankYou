if defined?(Footnotes) && Rails.env.development?
  # Footnotes.setup do |f|
  #   Footnotes.enabled = true
  #   f.prefix = 'x-mine://open?file=%s&line=%d'
  #   f.lock_top_right = true
  # end
end

if defined?(BetterErrors) && Rails.env.development?
  BetterErrors.editor = 'x-mine://open?file=%{file}&line=%{line}'
end
