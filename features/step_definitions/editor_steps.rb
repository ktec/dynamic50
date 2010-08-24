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

When /^I submit the command "([^"]*)"$/ do |command|
  @editor.command(command)
end

Then /^a new image should be created$/ do
  @editor.should respond_to(:image)
  @editor.image.should_not be_empty
end




