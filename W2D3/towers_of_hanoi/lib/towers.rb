
class Towers
  attr_reader :towers

  def initialize(size)
    @size = size
    @towers = Array.new(3) { Array.new }
    (1..size).to_a.reverse.each do |i|
      @towers[0] << i
    end
  end

  def move(start_tower, end_tower)
    raise "No disks on that tower" if @towers[start_tower].empty?
    start_disk = @towers[start_tower].last
    end_disk = @towers[end_tower].last
    raise "That disk is too large" if end_disk && start_disk > end_disk

    @towers[end_tower] << @towers[start_tower].pop
  end

  def won?
    (@towers[1].length == @size) || (@towers[2].length == @size)
  end

  def prompt
    puts "Enter two towers:"
    gets.chomp.split(",").map(&:to_i)
  end

  def render
    system("clear")
    @towers.each_with_index do |row, i|
      puts "#{i} #{row.join(" ")}"
    end
  end

  def play
    render
    until won?
      begin
        move = prompt
        move(move[0], move[1])
        render
      rescue => e
        puts e.message
      end
    end
    puts "won!"
  end

end

#a = Towers.new(3)
#a.play
