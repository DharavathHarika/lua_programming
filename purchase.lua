local Purchase = {}

function Purchase.new(item, quantity, cost)
  local self = {}
  self.item = item
  self.quantity = quantity
  self.cost = cost
  return self
end

return Purchase
