local Person = {}

function Person.new(name, email, phone)
  local self = {}
  self.name = name
  self.email = email
  self.phone = phone
  return self
end

return Person
