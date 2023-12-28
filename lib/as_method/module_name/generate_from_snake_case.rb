# frozen_string_literal: true

module AsMethod
  module ModuleName
    module GenerateFromSnakeCase
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

        escaped_replacements = REPLACEMENTS.keys.map { Regexp.escape(_1) }
        string.to_s
          .sub(/^(_|#{escaped_replacements.join('|')})/, "SPECIAL\\1")
          .gsub(/(^|_)([a-z])/) { ::Regexp.last_match(2).capitalize.to_s }
          .gsub(/[#{Regexp.escape(REPLACEMENTS.keys.join)}]/, REPLACEMENTS)
      end
    end # ... GenerateFromSnakeCase
  end # ... ModuleName
end
