local Person = require 'person'
local Purchase = require 'purchase'

local Customer = {}
Customer.__index = Customer
setmetatable(Customer, { __index = Person })

function Customer.new(name, email, phone)
  local self = setmetatable({}, Customer)
  self.name = name
  self.email = email
  self.phone = phone
  self.purchases = {}
  return self
end

function Customer:add_purchase(item, quantity, cost)
  table.insert(self.purchases, Purchase.new(item, quantity, cost))
end

function Customer:display()
  print(self.name .. " <" .. self.email .. "> Phone: " .. self.phone)
end

function Customer:display_purchase()
  local size = #self.purchases
  for j = 1, size do
    local sale = self.purchases[j]
    print(sale.item .. "\t\t" .. sale.cost .. "\t" .. sale.quantity .. "\t" .. sale.cost * sale.quantity)
  end
end

return Customer
