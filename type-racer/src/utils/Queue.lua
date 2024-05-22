Queue = Class{}
_QNode = Class{}

function Queue:init()
    self.head = nil
    self.tail = nil
end

function Queue:enqueue(value)
    assert(value ~= nil)

    if self.tail == nil then
        assert(self.head == nil)
        
        self.head = _QNode(value)
        self.tail = self.head
    else
        local newTail = _QNode(value)

        self.tail.next = newTail
        self.tail = newTail
    end         
end

function Queue:remove()
    assert(self.head ~= nil)
    assert(self.tail ~= nil)

    local value = self.head.value

    if self.head == self.tail then
        self.head = nil
        self.tail = nil
    else
        self.head = self.head.next
    end

    return value
end

function Queue:isEmpty()
    assert(not (self.head == nil and self.tail ~= nil))
    assert(not (self.tail == nil and self.head ~= nil))
    return self.head == nil and self.tail == nil
end

function Queue:clear()
    self.head = nil
    self.tail = nil
end

function _QNode:init(value)
    self.value = value
    self.next = nil
end
