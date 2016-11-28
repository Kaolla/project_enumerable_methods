module Enumerable

	def my_each
		return enum_for(:my_each) unless block_given?
		i = 0
		while i < self.size
			yield(self[i])
			i += 1
		end
		self
	end

	def my_each_with_index
		return enum_for(:my_each_with_index) unless block_given?
		i = 0
		while i < self.size
			yield(self[i], i )
			i += 1
		end
	end

	def my_select
		return enum_for(:my_select) unless block_given?
		selected = []
		self.my_each { |item| selected << item if yield(item) }
		return selected
	end

	def my_all?
		status = true
		self.my_each do |item|
			status = false if (block_given? && !yield(item)) || (!block_given? && !item)
		end 
		status
	end

	def my_any?
		status = false
		self.my_each do |item|
			status = true if (block_given? && yield(item)) || (!block_given? && item)
		end 
		status
	end

	def my_none?
		status = true
		self.my_each do |item|
			status = false if (block_given? && yield(item)) || (!block_given? && item)
		end 
		status
	end

	def my_count
		return self.length unless block_given?
		count = 0
		self.my_each { |item| count += 1 if yield(item) }
		return count
	end

	def my_map(&proc)
		return enum_for(:my_map) unless block_given?
		self.my_each_with_index do |item, index| 
			if block_given?
				self[index] = yield(item)
			else
				self[index] = proc.call(item)
			end
		end
		self
	end

	def my_inject(count=nil)
		memo = count.nil? ? self[1...size] : self
		count ||= self[0]
		memo.my_each { |i| count = yield(count, i) }
		count
	end

	def multiply_els
	    self.my_inject { |x, y| x * y }
	end

end
