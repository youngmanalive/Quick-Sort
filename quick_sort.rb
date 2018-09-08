# Quick Sort in-place

class Array
  def quick_sort!(&prc)
    prc ||= Proc.new { |a, b| a <=> b }
    _quick_sort!(0, self.length, &prc)
  end

  def quick_sort(&prc)
    dup.quick_sort!(&prc)
  end

  protected
  def _quick_sort!(start = 0, len = self.length, &prc)
    return self if len < 1
    pivot = _partition(start, len, &prc)
    _quick_sort!(start, pivot-start, &prc)
    _quick_sort!(pivot+1, len-(pivot-start+1), &prc)
    self
  end

  def _partition(start, len, &prc)
    pivot_idx = start
    pivot = self[start]

    ((start+1)...(start+len)).each do |i|
      if prc.call(pivot, self[i]) > 0
        self[pivot_idx+1], self[i] = self[i], self[pivot_idx+1]
        pivot_idx += 1
      end
    end

    self[pivot_idx], self[start] = self[start], self[pivot_idx]
    pivot_idx
  end
end
