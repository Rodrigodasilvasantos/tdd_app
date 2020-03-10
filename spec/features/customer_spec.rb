require 'rails_helper'

feature "Customer", type: :feature do
  scenario "Verify Customer base" do
    visit(root_path)
    expect(page).to have_link('Cadastro de Clientes')
  end

  scenario "Verify New Client link" do
    visit(root_path)
    click_on("Cadastro de Clientes")
    expect(page).to have_content('Listando Clientes')
    expect(page).to have_link('Novo Cliente')
  end

  scenario "Verify New Client form" do
    visit(customers_path)
    click_on('Novo Cliente')
    expect(page).to have_content('Novo Cliente')
  end

  scenario "Register a new customer" do
    visit(new_customer_path)
    customer_name = Faker::Name.name

    fill_in('customer_name', with: customer_name)
    fill_in('customer_email', with: Faker::Internet.email)
    fill_in('customer_phone', with: Faker::PhoneNumber.phone_number)
    #attach_file('customer_avatar', "#{Rails.root}/spec/fixtures/avatar.png")
    choose(option: ['S','N'].sample)
    click_on('Criar Cliente')

    expect(page).to have_content('Cliente cadastrado com sucesso')
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario "Doesn't register a new customer" do
    visit(new_customer_path)
    click_on('Criar Cliente')
    expect(page).to have_content('não pode ficar em branco')
  end

  scenario "Shows a customer" do
    customer = create(:customer)
    visit(customer_path(customer.id))
    expect(page).to have_content(customer.name)
  end 

  scenario "Shows a customer page" do
    customer1 =  customer = create(:customer)

    customer2 =  customer = create(:customer)
    visit(customers_path)
    expect(page).to have_content(customer1.name).and have_content(customer2.name)
  end 

  scenario "updates a customer" do
    customer =  customer = create(:customer)
    new_name = Faker::Name.name
    visit(edit_customer_path(customer.id))
    fill_in('Nome', with: new_name)
    click_on("Atualizar Cliente")

    expect(page).to have_content("atualizado com sucesso")
    expect(page).to have_content(new_name)
  end

  scenario "click on Mostrar link" do
    customer =  customer = create(:customer)

    visit(customers_path)
    click_on("Mostrar")
    expect(page).to have_content("Listagem de Clientes")
  end

  scenario "click on Editar link" do
    customer =  customer = create(:customer)

    visit(customers_path)
    click_on("Editar")
    expect(page).to have_content("Edição de Clientes")
  end

  scenario "Delete a client" do
    customer =  customer = create(:customer)

    visit(customers_path)
    click_on("Excluir")
    expect(page).to have_content('Cliente excluido')

  end
end
