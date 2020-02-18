require 'rails_helper'

feature "Welcome", type: :feature do
 scenario 'Shows Welcome message' do
  visit('/')
  expect(page).to have_content('Bem-vindo')
 end
end
