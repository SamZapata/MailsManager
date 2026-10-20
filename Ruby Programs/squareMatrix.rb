require "debug"

def preparation(samples)
  sResults = {}
  samples.each_with_index do |sample, i|
    x1s = 0
    sample.each_with_index do |sValue, j|
      sValue == 1 ? x1s += 1 : x1s = 0
      sResults[i] ||= []
      if x1s > 1
        for k in 2..x1s do
          sResults[i].push({j => k})
        end
      else
        sResults[i].push({j => x1s})
      end
    end
  end
  
  puts sResults
  sResults
end

def inspection(results)
  hValues = {}
  results.each do |row, samples|
    hValues[row] ||= []
    samples.sort_by {|h| -h.values.first}.each do |hv|
      cnt = 1
      for i in row+1..results.length-1
        if results[i].find { |f| f == hv }
          cnt += 1
          if cnt == hv.values.first && hv.values.first > 1
            hValues[row] << (hv)
            next
          end
        else
          break
        end
      end
    end
  end
  puts "High Values: #{hValues}"
  hValues
end

def counting(hValues)
  hvs = {"res" => []}
  hValues.each do |r, v|
    hvs["res"] << v.compact.max_by {|m| m.values.first}
  end
  hv = hvs["res"].compact.max_by {|m| m.values.first}
  result = 0
  hValues.each do |r, v|
    v.find do |f|
      if f.values.first == hv.values.first
        result += 1
        next
      end
    end
  end
  puts "Total => #{result}"
  result
end

if __FILE__ == $PROGRAM_NAME
  rows = gets.to_i
  cols = gets.to_i
  matrix = []
  rows.times do
    matrix << gets.split.map(&:to_i)
  end

  results = preparation(matrix)
  hValues = inspection(results)
  counting(hValues)
  
end

