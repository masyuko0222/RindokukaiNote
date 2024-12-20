# frozen_string_literal: true

module ReadingClubHelper
  def radio_button_with_label(form, method, tag_value, options = {})
    id = options[:id]
    checked = options[:checked]
    label_text = options[:label_text]

    content_tag :label, class: 'inline-flex items-center space-x-1' do
      concat(form.radio_button(method, tag_value, id:, checked:))
      concat(content_tag(:span, label_text, class: 'text-sm text-gray-700'))
    end
  end

  def read_me_to_html(md_text)
    return unless md_text

    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    html_text = markdown.render(md_text)

    sanitize_html(html_text)
  end

  private

  def sanitize_html(html_text)
    tags = %w[h1 h2 h3 h4 h5 h6 p strong em a ul ol li code pre]
    attributes = %w[href]
    sanitize(html_text, tags:, attributes:)
  end
end
