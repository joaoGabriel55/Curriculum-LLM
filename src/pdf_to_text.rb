require "pdf-reader"

def pdf_to_text(pdf_path, txt_path)
  text = ""

  PDF::Reader.open(pdf_path) do |reader|
    reader.pages.each do |page|
      text << page.text
      text << "\n\n--- page #{page.number} ---\n\n"  # optional page separator
    end
  end

  File.write(txt_path, text)
  puts "Converted #{pdf_path} → #{txt_path} (#{text.length} characters)"
rescue PDF::Reader::MalformedPDFError => e
  puts "Error: This PDF seems corrupted or not text-based: #{e.message}"
rescue => e
  puts "Failed: #{e.class} - #{e.message}"
end
