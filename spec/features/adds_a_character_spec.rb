require 'rails_helper'

feature 'user adds a new character', %Q{
As a site visitor
I want to add my favorite TV show characters
So that other people can enjoy their crazy antics
} do

# Acceptance Criteria:
# * I can access a form to add a character on a TV show's page
# * I must specify the character's name and the actor's name
# * I can optionally provide a description
# * If I do not provide the required information, I receive an error message
# * If the character already exists in the database, I receive an error message

scenario 'user adds a character to TV show' do

  show = TelevisionShow.create(title: 'The Wire', network: 'HBO' )

  attrs = {
    name: 'Stringer Bell',
    actor: 'Idris Elba',
    description: 'Entreprenuer',
    television_show_id: "#{show.id}"
  }

  char = Character.new(attrs)

  visit "/television_shows/#{show.id}"
  fill_in 'Name', with: char.name
  fill_in 'Actor', with: char.actor
  fill_in 'Description', with: char.description
  click_on 'Submit'

  expect(page).to have_content char.name
  expect(page).to have_content char.actor
  expect(page).to_not have_content char.description
end

scenario 'submit without required fields' do
  show = TelevisionShow.create(title: 'The Wire', network: 'HBO' )

  visit "/television_shows/#{show.id}"
  click_on 'Submit'

  expect(page).to_not have_content 'Success'
  expect(page).to have_content "Your Character could not be saved!"
end

scenario 'submit record that laready exists in DB' do
   show = TelevisionShow.create(title: 'The Wire', network: 'HBO' )
   char = Character.create(name: 'Omar', actor: 'Michael K Williams',
          television_show_id: "#{show.id}")

   visit "/television_shows/#{show.id}"
   fill_in 'Name', with: char.name
   fill_in 'Actor', with: char.actor
   click_on 'Submit'

   expect(page).to_not have_content 'Success'
   expect(page).to have_content "Your Character could not be saved!"
 end

end







