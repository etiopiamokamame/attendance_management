module ApplicationHelper
  def header_messages(model_name = nil)
    render partial: "layouts/header_messages",
      locals: {model_name: model_name}
  end

  def header_title(title)
    content_tag(:div,
      content_tag(:div,
        title, class: "title"
      ),
      class: "header-title"
    )
  end

  def error_message_for(model_name = nil)
    return nil if model_name.blank?
    model = instance_eval "@#{model_name}"
    return nil if model.errors.blank?
    content_tag(:div,
      content_tag(:div,
        t("error.some_errors", count: model.errors.messages.count),
        class: "some-error"
      ) + content_tag(:ul,
        model.errors.full_messages.inject(""){|str, msg| str << content_tag(:li, msg) }.html_safe
      ),
      class: "error-message"
    )
  end

  # TODO 現状未使用
  def decide_has_error(model, attr)
    model = instance_eval "@#{model}"
    return "" if model.errors[attr].blank?
    "field_with_errors"
  end
end
