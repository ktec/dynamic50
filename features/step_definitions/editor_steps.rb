class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end

Given /^I am not already drawing a great picture$/ do
end

When /^I start a new session$/ do
  @editor = Graphics::Editor.new(output)
  @editor.start
end

Then /^I should see "([^"]*)"$/ do |message|
  output.messages.should include(message)
end

Then /^I should see the image$/ do 
  output.messages.should include("00000\n00000\n00000\n00000\n00000\n00000\n")
end


When /^I submit the command "([^"]*)"$/ do |command|
  @editor.command(command)
end





