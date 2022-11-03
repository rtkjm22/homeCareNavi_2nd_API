D = Steep::Diagnostic
target :lib do
  signature 'sig'

  check 'app/controllers/*.rb'
  check 'app/controllers/**/*.rb' # Directory name
  check 'app/models/*.rb'
  check 'app/models/**/*.rb'
  # check "Gemfile"                   # File name
  # check "app/models/**/*.rb"        # Glob
  # ignore "lib/templates/*.rb"

  # library "pathname", "set"       # Standard libraries
  # library "strong_json"           # Gems

  # configure_code_diagnostics(D::Ruby.strict)       # `strict` diagnostics setting
  configure_code_diagnostics(D::Ruby.lenient)      # `lenient` diagnostics setting
  configure_code_diagnostics do |hash|             # You can setup everything yourself
    hash[D::Ruby::UnsupportedSyntax] = :hint
    hash[D::Ruby::UnresolvedOverloading] = :hint
  end
end

# target :test do
#   signature "sig", "sig-private"
#
#   check "test"
#
#   # library "pathname", "set"       # Standard libraries
# end
