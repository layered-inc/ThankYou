module MessagesHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: false,
      tables: true,
      space_after_headers: true,
      hard_wrap: true,
      xhtml: true,
      underline: true,
      highlight: true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end
