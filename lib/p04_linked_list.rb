require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new()
    @tail = Link.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    self.each { |link| return link if link.key == i }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    link = @head.next
    until link == @tail
      return link.val if link.key == key
      link = link.next
    end
    nil
  end

  def include?(key)
    link = @head.next
    until link == @tail
      return true if link.key == key
      link = link.next
    end
    false
  end

  def insert(key, val)
    self.each { |link| return link.val = val if link.key == key }

    old_prev = @tail.prev
    new_link = Link.new(key, val)
    @tail.prev = new_link
    new_link.next = @tail
    new_link.prev = old_prev
    old_prev.next = new_link
  end

  def remove(key)
    link = @head.next
    until link == @tail
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
      end
      link = link.next
    end
  end

  def each
    link = @head.next
    until link == @tail
      yield link
      link = link.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
