# TODO
# configでなぜかautoloadされない為、一時的にここに配置
module Excel
  class AxlsxUtil
    attr_accessor :package

    def initialize
      @package = Axlsx::Package.new
      @package.use_autowidth = false
    end

    def add_worksheet(name)
      package.workbook.styles do |style|
        package.workbook.add_worksheet(name: name) do |sheet|
          yield Sheet.new(sheet, style)
        end
      end
      self
    end

    def method_missing(method_name, *args)
      if package.class.method_defined?(method_name)
        package.__send__(method_name, *args)
      else
        super
      end
    end
  end

  class Sheet
    attr_accessor :sheet
    attr_accessor :style
    attr_accessor :col
    attr_accessor :row

    START_POINT_ROW = "0".freeze
    START_POINT_COL = "A".freeze

    def initialize(sheet, style)
      @sheet = sheet
      @style = Style.new(style)
      @row   = START_POINT_ROW.dup
      @col   = START_POINT_COL.dup
      @stack = []
    end

    def add_col(value, options = {})
      add_stack(value, options)
    end

    def add_col!(value, options = {})
      add_stack(value, options)
      add_row
    end

    def add_row(values = [], options = {})

      if (values.blank? || options.blank?) && @stack.present?
        values          = []
        options[:style] = []
        # TODO
        # options[:type]  = []
        @stack.each do |stack|
          s                = stack || {}
          values          << s[:value]
          options[:style] << s[:style]
          # TODO
          # options[:type]  << s[:type]
        end
      end
      sheet.add_row values, options
      @stack = []
      row.succ!
    end

    def row_next!
      add_row
    end

    def method_missing(method_name, *args)
      if sheet.class.method_defined?(method_name)
        sheet.__send__(method_name, *args)
      else
        super
      end
    end

    private

    def add_stack(value, options = {})
      stack         = {}
      stack[:value] = value
      stack[:style] = style.add_style(options[:style]) unless options.blank?
      stack[:type]  = options[:type]                   unless options.blank?
      if options[:col_index].blank?
        @stack << stack
      else
        index         = options[:col_index].alpha_to_i - col.alpha_to_i
        @stack[index] = stack
      end
    end
  end

  class Style
    attr_accessor :style

    STYLE_PATTERN = {
      default: {
        sz: 40
      },
      date_body: {
        font_name: "明朝",
        sz:        14
      },
      date_header: {
        font_name: "MS Pゴシック",
        sz:        14
      }
    }.freeze

    def initialize(style)
      @style = style
    end

    def add_style(type = :default)
      return if type.blank?
      style.add_style STYLE_PATTERN[type]
    end

    def method_missing(method_name, *args)
      if style.class.method_defined?(method_name)
        style.__send__(method_name, *args)
      else
        super
      end
    end
  end
end
