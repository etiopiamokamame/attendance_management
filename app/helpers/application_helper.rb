# frozen_string_literal: true
module ApplicationHelper
  def load_menu
    menu_list  = []
    login_user = current_user
    Rails.application.config.side_menu.menu.each do |menu|
      next if menu[:admin] && !login_user.admin?
      list_options         = {}
      list_options[:class] = "header" if menu[:header]

      list_body = if menu[:path].blank?
                    t(".#{menu[:title]}")
                  else
                    link_to menu[:path] do
                      tags  = []
                      tags << content_tag(:i, nil, class: "fa #{menu[:icon]}")
                      tags << content_tag(:span, t(".#{menu[:title]}"))
                      safe_join tags
                    end
                  end

      menu_list << content_tag(:li, list_body, list_options)
    end

    safe_join menu_list
  end

  def datatable_script(table_id, default_order, options = {})
    <<~JS
      <script>
        $("##{table_id}").dataTable({
          lengthChange: true,
          searching:    false,
          ordering:     true,
          info:         true,
          paging:       true,
          order:        [#{default_order}, "#{options[:order] || 'asc'}"],
          columnDefs:   [{orderable: false, targets: #{options[:column_defs] || []}}],
          lengthMenu:   [[10, 20, 50, -1], [10, 20, 50, "#{t('datatable.lengthMenuAll')}"]],
          language: {
            emptyTable:     "#{t('datatable.emptyTable')}",
            info:           "#{t('datatable.info')}",
            infoEmpty:      "#{t('datatable.infoEmpty')}",
            infoFiltered:   "#{t('datatable.infoFiltered')}",
            infoPostFix:    "#{t('datatable.infoPostFix')}",
            thousands:      "#{t('datatable.thousands')}",
            lengthMenu:     "#{t('datatable.lengthMenu')}",
            loadingRecords: "#{t('datatable.loadingRecords')}",
            processing:     "#{t('datatable.processing')}",
            search:         "#{t('datatable.search')}",
            zeroRecords:    "#{t('datatable.zeroRecords')}",
            paginate: {
              first:    "先頭",
              previous: "前へ",
              next:     "次へ",
              last:     "末尾"
            }
          }
        });
      </script>
    JS
  end
end
