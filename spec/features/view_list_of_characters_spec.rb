require 'rails_helper'

feature 'user views a list of tv characters', %Q{
  As a site visitor I want to view a list of people's favorite TV characters
  So I can find wonky characters to watch
  } do

  #Acceptance Criteria:
  # * I can see a list of all the characters
  # * The character's name and the TV show it is associated with are listed

  scenario 'user views tv characters and related shows' do
    show = TelevisionShow.create(title: 'The Wire', network: 'HBO' )
    show2 = TelevisionShow.create(title: 'The Sopranos', network: 'HBO')
    characters = []

    char_attrs = [
      { name: 'Omar', actor: 'Michael K Williams', description: 'Omar coming!',
       television_show_id: "#{show.id}"},
       {name: 'Tony Soprano', actor: 'James Gandolfini', description: 'Forget about it',
        television_show_id: "#{show2.id}"}
      ]

    char_attrs.each do |attrs|
      characters << Character.create(attrs)
    end

    visit '/characters'
    characters.each do |char|
      expect(page).to have_content char.name
      expect(page).to have_content char.actor
      expect(page).to have_content char.television_show.title #how to call show name
    end
  end
end
