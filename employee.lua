local Person = require 'person'

local Employee = {}
Employee.__index = Employee
setmetatable(Employee, { __index = Person })

function Employee.new(name, email, phone, salary)
  local self = setmetatable({}, Employee)
  self.name = name
  self.email = email
  self.phone = phone
  self.salary = salary
  return self
end

return Employee
