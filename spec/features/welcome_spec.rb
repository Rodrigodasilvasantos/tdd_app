require 'rails_helper'

feature "Welcome", type: :feature do
 	scenario 'Shows Welcome message' do
		visit(root_path)
		expect(page).to have_content('Bem-vindo')
	end

	scenario 'Verify customer base link'do
    visit(root_path)
		expect(find('ul li')).to have_link('Cadastro de Clientes')
	end
end
