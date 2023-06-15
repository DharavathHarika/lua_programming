local Customer = require 'customer'
local Employee = require 'employee'
local Purchase = require 'purchase'

local Companydb = {}
Companydb.__index = Companydb

function Companydb.new(name)
  local self = setmetatable({}, Companydb)
  self.name = name
  self.employees = {}
  self.customers = {}
  return self
end

function Companydb:add_employee(employee)
  table.insert(self.employees, employee)
end

function Companydb:add_customer(customer)
  table.insert(self.customers, customer)
end

function Companydb:display_employees()
  for _, employee in ipairs(self.employees) do
    print(string.format("%s\t<%s>\tPhone: %s\tSalary: $%.2f", employee.name, employee.email, employee.phone, employee.salary))
  end
end

function Companydb:display_customers()
  if #self.customers == 0 then
    print('Error: No Customers.')
  else
    for i, customer in ipairs(self.customers) do
      print(string.format("%d.) %s", i, customer.name))
    end
  end
end

function Companydb:save_data()
  local file = io.open(self.name .. '.dat', 'w')
  if file then
    file:write(#self.employees .. "\n")
    for _, employee in ipairs(self.employees) do
      file:write(employee.name .. "\n")
      file:write(employee.email .. "\n")
      file:write(employee.phone .. "\n")
      file:write(employee.salary .. "\n")
    end

    file:write(#self.customers .. "\n")
    for _, customer in ipairs(self.customers) do
      file:write(customer.name .. "\n")
      file:write(customer.email .. "\n")
      file:write(customer.phone .. "\n")
      file:write(#customer.purchases .. "\n")
      for _, purchase in ipairs(customer.purchases) do
        file:write(purchase.item .. "\n")
        file:write(purchase.quantity .. "\n")
        file:write(purchase.cost .. "\n")
      end
    end
    file:close()
  else
    print("Error: Failed to save data.")
  end
end

function Companydb:load_data(company_name)
  local file_path = company_name .. ".dat"
  local file = io.open(file_path, "r")
  if file then
    local company = Companydb.new(company_name)

    local no_of_employees = tonumber(file:read("*line"))
    for i = 1, no_of_employees do
      local name = file:read("*line")
      local email = file:read("*line")
      local phone = file:read("*line")
      local salary = tonumber(file:read("*line"))
      if salary == nil then
        salary = 0
      end
      company:add_employee(Employee.new(name, email, phone, salary))
    end

    local no_of_customers = tonumber(file:read("*line"))
    for i = 1, no_of_customers do
      local name = file:read("*line")
      local email = file:read("*line")
      local phone = file:read("*line")
      local no_of_purchases = tonumber(file:read("*line"))
      if no_of_purchases == nil then
        no_of_purchases = 0
      end
      local purchases = {}
      for j = 1, no_of_purchases do
        local item = file:read("*line")
        local quantity = tonumber(file:read("*line"))
        if quantity == nil then
          quantity = 0
        end
        local cost = tonumber(file:read("*line"))
        if cost == nil then
          cost = 0
        end
        table.insert(purchases, Purchase.new(item, quantity, cost))
      end
      local customer = Customer.new(name, email, phone)
      customer.purchases = purchases
      company:add_customer(customer)
    end

    file:close()
    return company
  else
    return Companydb.new(company_name)
  end
end

local function prompt(message)
  io.write(message)
  return io.read():gsub("\n", "")
end

local function readNumericChoice()
  local choice
  repeat
    local input = prompt('Choice? ')
    choice = tonumber(input, 10)
    if choice == nil then
      print('Invalid choice. Please enter a valid number.')
    end
  until choice ~= nil
  return choice
end

local function readData(data, company_name)
  local company = Companydb.new(company_name)
  local no_of_employees = tonumber(data[1])
  local j = 0
  local index = 0

  for i = 1, no_of_employees do
    local name = data[j + 1]:gsub("^%s*(.-)%s*$", "%1")
    local email = data[j + 2]:gsub("^%s*(.-)%s*$", "%1")
    local phone = data[j + 3]:gsub("^%s*(.-)%s*$", "%1")
    local salary = tonumber(data[j + 4],10)
    j = j + 4
    index = j + 1
    company:add_employee(Employee.new(name, email, phone, salary))
  end

  local no_of_customers = tonumber(data[index])
  for i = 1, no_of_customers do
    local name = data[index + 1]:gsub("^%s*(.-)%s*$", "%1")
    local email = data[index + 2]:gsub("^%s*(.-)%s*$", "%1")
    local phone = data[index + 3]:gsub("^%s*(.-)%s*$", "%1")
    local purchases = {}
    local no_of_purchases = tonumber(data[index + 4])
    local nowIndex = index + 4

    for j = 1, no_of_purchases do
      local item = data[nowIndex + 1]:gsub("^%s*(.-)%s*$", "%1")
      local quantity = tonumber(data[nowIndex + 2])
      local cost = tonumber(data[nowIndex + 3])
      nowIndex = nowIndex + 3
      table.insert(purchases, Purchase.new(item, quantity, cost))
    end

    local customer = Customer.new(name, email, phone)
    customer.purchases = purchases
    company:add_customer(customer)
    index = nowIndex
  end

  return company
end

local company_name = prompt('Enter the name of the company: ')
local company = Companydb:load_data(company_name)

while true do
  print("\nMAIN MENU:")
  print('1.) Employees')
  print('2.) Sales')
  print('3.) Quit')

  local choice = readNumericChoice()

  if choice == 1 then
    while true do
      company:display_employees()
      print()
      local employees_choice = prompt('(A)dd Employee or (M)ain Menu?')

      if employees_choice == 'M' then
        break
      elseif employees_choice == 'A' then
        local employee_name = prompt('Name: ')
        local employee_email = prompt('Email: ')
        local phone = prompt('Phone: ')
        local salary = tonumber(prompt('Salary: '), 10)
        company:add_employee(Employee.new(employee_name, employee_email, phone, salary))
      else
        print('Invalid choice.')
      end
    end
  elseif choice == 2 then
    while true do
      local sales_customers_choice = prompt('(A)dd Customer, Enter a (S)ale, (V)iew Customer, or (M)ain Menu?')

      if sales_customers_choice == 'A' then
        local customer_name = prompt("Name: ")
        local email = prompt("Email: ")
        local phone = prompt("Phone: ")
        company:add_customer(Customer.new(customer_name, email, phone))
      elseif sales_customers_choice == 'S' then
        company:display_customers()
        if #company.customers > 0 then
          local choice_of_customer = readNumericChoice()
          local customer_name = company.customers[choice_of_customer]

          local item = prompt('Item: ')
          local quantity = tonumber(prompt('Quantity: '),10)
          local cost = tonumber(prompt('Cost: '),10)
          customer_name:add_purchase(item, quantity, cost)
        end
      elseif sales_customers_choice == 'V' then
        company:display_customers()
        if #company.customers > 0 then
          local choice_of_customer = readNumericChoice()
          local customer_name = company.customers[choice_of_customer]
          customer_name:display()
          print("\nOrder History")
          print("Item \t\t Price  Quantity  Total")
          customer_name:display_purchase()
        end
      elseif sales_customers_choice == 'M' then
        break
      else
        print('Invalid choice.')
      end
    end
  elseif choice == 3 then
    company:save_data()
    break
  else
    print('Invalid choice.')
  end
end
