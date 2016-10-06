require 'erb'

def save(text, filename)
  File.write("./#{filename}", ERB.new(sub_strings(text)).result)
end

def sub_strings(input_string)
  output_string = input_string
  input_string.scan(/{{(\w*)}}/).each do |var|
    replacement = ["# #{var[0].upcase} BEGIN", File.read("shared/#{var[0]}.erb"), "# #{var[0].upcase} END"].join("\n")

    output_string.gsub!("{{#{var[0]}}}", replacement)
  end

  output_string.strip
end
