module ApplicationHelper
  def header_messages(model_name = nil)
    render partial: "layouts/header_messages",
      locals: { model_name: model_name }
  end

  def header_title(title)
    content_tag(:div, content_tag(:h1, title), class: "content-heder")
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

  def load_menu
    html       = ""
    login_user = User.find(session[:userid])
    Rails.application.config.side_menu.menu.each do |menu|
      next if menu[:admin] && !login_user.admin
      if menu[:tree_path].blank?
        link_title = t(".#{menu[:title]}")
        link_html  = link_to menu[:path] do
          h = <<-EOF
            #{image_tag(menu[:icon])}
            <span class="title #{session[:hidden_sidebar] ? 'disable' : 'active'}">
              #{link_title}
            </span>
          EOF
          h.html_safe
        end
        html += <<-EOF
          <ul class="#{menu[:tree_class]}">
            <li>
              #{link_html}
            </li>
          </ul>
        EOF
      else
        tree_html = ""
        menu[:tree_path].each do |tree_menu|
          label_title = t(".#{tree_menu[:title]}")
          link_body   = <<-EOF
            <label class="title #{session[:hidden_sidebar] ? 'disable' : 'active'}">
              #{label_title}
            </label>
          EOF
          link_html   = link_to tree_menu[:path] do
            image_tag(tree_menu[:icon]) + link_body.html_safe
          end
          tree_html += <<-EOF
            <li>
              #{link_html}
            </li>
          EOF
        end
        label_title = t(".#{menu[:title]}")
        html       += <<-EOF
          <label class="#{menu[:label_class]}">
            #{image_tag(menu[:icon])}
            <span class="title #{session[:hidden_sidebar] ? 'disable' : 'active'}">
              #{label_title}
            </span>
          </label>
          <ul class="#{menu[:tree_class]}">
            #{tree_html}
          </ul>
        EOF
      end
    end

    html.html_safe
  end
end
