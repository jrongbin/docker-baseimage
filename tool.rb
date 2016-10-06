require 'erb'
require 'fileutils'

def save(text, filename, &block)
  _, dir = filename.reverse.split('/', 2).map { |i| i.reverse }
  FileUtils.mkdir_p "./#{dir}"

  File.write("./#{filename}", ERB.new(sub_strings(text)).result)

  if block_given?
    yield
  end
end

def sub_strings(input_string)
  output_string = input_string
  input_string.scan(/{{(\w*)}}/).each do |var|
    replacement = ["# #{var[0].upcase} BEGIN", File.read("shared/#{var[0]}.erb"), "# #{var[0].upcase} END"].join("\n")

    output_string.gsub!("{{#{var[0]}}}", replacement)
  end

  output_string.strip
end
