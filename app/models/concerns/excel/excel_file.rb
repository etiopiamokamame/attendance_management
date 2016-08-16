# TODO
# configでなぜかautoloadされない為、一時的にここに配置
module Excel
  module ExcelFile
    def create_attendance_excel(attendance)
      excel = AxlsxUtil.new

      attendance_data(excel, attendance)

      excel
    end

    private

    def attendance_data(excel, attendance)
      excel.add_worksheet(attendance.date_str) do |sheet|
        # セル幅
        #                   A, B, C, D,  E, F,  G, H,  I,  J,  K,  L,  M,  N,  O,  P,  Q,  R, S,  T, U,  V,  W,  X
        sheet.column_widths(3, 0, 3, 3, 10, 8, 10, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 3, 10, 3, 20, 10, 10)

        sheet.row_next!

        # 日付
        date_col_index = "E"
        sheet.add_col(attendance.year, { style: :date_body, col_index: date_col_index })
        sheet.add_col(attendance.class.human_attribute_name(:year), { style: :date_header, col_index: date_col_index.succ! })
        sheet.add_col(attendance.month, { style: :date_body, col_index:  date_col_index.succ! })
        sheet.add_col!(attendance.class.human_attribute_name(:month), { style: :date_header, col_index: date_col_index.succ! })

        # sheet.add_row()
      end
    end

    module_function :create_attendance_excel
    module_function :attendance_data
  end
end
