require 'rails_helper'

  feature 'user removes a character from the db', %Q{
    As a site visitor
    I want to delete a character I don't like
    So no one else will want to watch that character
  } do

  # Acceptance Criteria:
  # * I can delete a character from the database
  # * If the record is successfully deleted, I receive an notice that it was deleted

  scenario 'user deletes character' do
    show = TelevisionShow.create(title: 'The Wire', network: 'HBO' )
    character = Character.create(name: 'Marlow', actor: 'Some dude', television_show_id: "#{show.id}")

    visit characters_path
    click_on 'Remove'

    expect(page).to_not have_content character.name
    expect(page).to_not have_content character.actor
    expect(page).to have_content 'Character Removed'
  end
end
