# frozen_string_literal: true

module AsMethod
  module ModuleName
    module GenerateFromUnderscored

      REPLACEMENTS = {
        "-" => "_Min",
        "!" => "_Exc",
        "?" => "_Que",
        "[" => "_Sbl",
        "]" => "_Sbr",
        "*" => "_Ast",
        "/" => "_Sla",
        "&" => "_Amp",
        "%" => "_Pct",
        "^" => "_Pwr",
        "+" => "_Plu",
        "<" => "_Lst",
        "=" => "_Eql",
        ">" => "_Gtt",
        "|" => "_Vbr",
        "~" => "_Til",
      }.freeze

      def self.call(string)
        return unless string
        
        string.to_s
          .gsub(/(?:_|(^))([a-z\d]{1})/) { "#{$1}#{$2.capitalize}" }
          .gsub(/[#{Regexp.escape(REPLACEMENTS.keys.join)}]/, REPLACEMENTS)
      end

    end # ... GenerateFromUnderscored
  end # ... ModuleName
end # ... AsMethod
