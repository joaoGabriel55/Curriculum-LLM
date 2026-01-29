require 'ruby_llm'
require 'pathname'
require "pdf-reader"
require 'json'
require './src/normalize_resume_tool.rb'
require './src/pdf_to_text.rb'

prompt =  File.read('prompt.md')
file_path = './src/json-schema.json'
json_schema = File.read(file_path)

if ARGV.empty?
  puts "ERROR: Usage: bundle exec ruby server_llm.rb <resume_file>"
  return
end

doc_file_path = "resumes/#{ARGV[0]}"
pdf_to_text("#{doc_file_path}.pdf", "#{doc_file_path}.txt")

# RubyLLM.configure do |config|
#   config.ollama_api_base = "http://localhost:11434/v1"
#   # config.openrouter_api_key = ENV['OPENROUTER_API_KEY']
# end

# # chat = RubyLLM.chat(model: 'anthropic/claude-opus-4.5', provider: :openrouter)
# chat = RubyLLM.chat(model: 'qwen2.5:14b', provider: :ollama)
#   .with_tool(NormalizeResumeTool)
#   .on_tool_call do |tool_call|
#     # Called when the AI decides to use a tool
#     puts "Calling tool: #{tool_call.name}"
#     puts "Arguments: #{tool_call.arguments.to_json}"
#   end
#   .on_tool_result do |result|
#     # Called after the tool returns its result
#     puts "Tool returned: #{result}"
#   end

# response = chat.ask("
#   #{prompt}
#   ```json
#   #{json_schema}
#   ```
# ", with: ["#{doc_file_path}.txt"])
