if defined?(Footnotes) && Rails.env.development?
  Footnotes.run! # first of all
  Footnotes::Filter.prefix = 'x-mine://open?file=%s&line=%d'
end

if defined?(BetterErrors) && Rails.env.development?
  BetterErrors.editor = 'x-mine://open?file=%{file}&line=%{line}'
end
