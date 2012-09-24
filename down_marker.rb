class DownMarker < Sinatra::Base
  attr :sections
  def sections
    @sections ||= Dir.glob("sections/*.md").map{|f| f.split("/").last.split(".").first}
  end

  def listing
    markdown sections.map{|s| "* [#{s}](/sections/#{s})"}.join("\n")
  end

  get "/" do
    listing
  end

  get "/sections/:file" do
    if sections.include?(params[:file])
      markdown File.read("sections/#{params[:file]}.md")
    else
      listing
    end
  end
end