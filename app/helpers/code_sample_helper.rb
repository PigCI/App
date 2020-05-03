module CodeSampleHelper
  def render_code_sample(partial, language: :ruby, locals: {})
    source = ApplicationController.render(partial: partial, locals: locals)
    formatter = Rouge::Formatters::HTMLPygments.new(Rouge::Formatters::HTML.new)
    lexer = Rouge::Lexer.find(language)
    formatter.format(lexer.lex(source)).html_safe
  end
end
