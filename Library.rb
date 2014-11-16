class Calendar
  # attr_accessor:date
  attr_reader(:date)
  def initialize()
    @date = 0
  end

  def get_date()
    t = Time.now
    d= t.strftime("%Y%m%d")
    return  d.to_i
  end

  def advance()
    @date = get_date + 1
    return   @date
  end
end

class Book
  attr_reader(:id, :title, :author, :dueDate )
  def initialize(id,title,author)
    @dueDate = 00000000
    @borrowPeriod = 6
    @id = id
    @title = title
    @author = author
  end
  def getId()
    return @id
  end
  def get_due_date()
    return @dueDate
  end
  def check_in()
    @dueDate = nil
  end
  def to_s #"id:title,by author”.
    #return "id: #{@id}, title #{@title}, by Author #{@author}"
  end
  def check_out(due_date)
    @dueDate = due_date
    # @dueDate =  Calendar.new().get_date()+ @borrowPeriod
  end
end

class Member
  attr_reader(:name, :bookBorrowed )
  def initialize(name,libraryName)
    @name = name
    @library = libraryName
    @bookBorrowed = []
  end

  def check_out(book)
    @bookBorrowed.push(book)
  end

  def give_back(book)
    @bookBorrowed.delete_at(@bookBorrowed.index(book))
  end

  def get_books()
    return @bookBorrowed
  end

  def send_overdue_notice(notice)
    puts self.name()+ notice
  end

end

class Library
  @@books = []
  @@isCalOn = false
  @@isCollectionReaded = false
  @@calendar = nil
  def initialize()
    createCalendar()
    readFile()
    @@members = Hash.new
    @@isLibOpen=false
    currentMember=nil ###
  end
  def open()
    if @@isLibOpen==true
      raise Exception.new("The library is already open")
    else
      @@isLibOpen=true
      @@calendar.advance()
      return "Today is day +1  #{@@calendar.date()}"
    end
  end
=begin
  listing the names of members who have overdue books, and for each such member, the
  books that are overdue. Or, the string "No books are overdue.”.
=end
  def find_all_overdue_books()
    puts "__3"#puts @@books[1]
    t=[]
    n=""
    getMember().each_pair do |key,obj|
      if obj.get_books.size == 0
        puts key
        puts " NO book are overdue "
      end
      for i in 0 ... obj.get_books.size
        if  ((obj.get_books.size > 0)&&
        (obj.get_books[i].get_due_date() >= @@calendar.get_date() ))
          n = key
          t.push(obj.get_books[i].title())
          t.push(obj.get_books[i].get_due_date())
        end
      end
    end
    print "#{n} has overdue \n"
    t.each do |i|
      print "#{i} , "
    end
=begin
    for i in 0 ... @@books.size
      if  (@@books[i].get_due_date() >= @@calendar.get_date() )
        # m= bookBorrowed[0].getId()
        puts "$$"
        puts id = @@books[i].id
      else
        puts "NO $$"
      end
    end
=end
  end
  
  def readFile()
    # Read File with Exception Handling
    if @@isCollectionReaded==false
      counter = 1
      begin
        file = File.new("collection.txt", "r")
        while (line = file.gets)
          # puts "#{counter}: #{line}"
          title,author = line.split(',').map(&:strip)
          makeBookList(counter-1,counter,title,author)
          counter = counter + 1
        end
        file.close
        @@isCollectionReaded=true
      rescue => err
        puts "Exception: #{err}"
        err
      end
    end
  end
  def makeBookList(i,id,title,author)
    @@books[i] = Book.new(id,title,author)
  end
  def getBookList ()
    return @@books
  end
  def getMember()
    return @@members
  end
  def addMember(name, obj)
    @@members[name] = obj
  end
  def createCalendar()
    if @@isCalOn == false
      @@calendar=Calendar.new()
      puts @@calendar.get_date()
      @@isCalOn = true
      puts @@isCalOn
    end
  end
end

###########################################START
l=Library.new();
begin
  puts l.open()
  l.open()
rescue Exception => e
  puts e.message
end

puts "ooo"
l.getBookList()[1].check_out(20141215)
# add member to lib
l.addMember(:ugo, Member.new("ugo","bbkLib"))
l.addMember(:pep, Member.new("pep","bbkLib"))

=begin 
=end
### Borrow Book
l.getMember()[:ugo].check_out(l.getBookList()[0])
l.getMember()[:ugo].check_out(l.getBookList()[1])
l.getBookList()[0].check_out(20141215) 
l.getBookList()[1].check_out(20141215) 
 
puts l.getMember()[:ugo].inspect
puts l.getMember()[:ugo].bookBorrowed[0].getId()
puts l.getMember()[:ugo].bookBorrowed[0].get_due_date
puts l.getMember()[:ugo].bookBorrowed[1].getId()


l.find_all_overdue_books()

=begin
  b= Book.new(111,"ttt","aaa")
  b2= Book.new(222,"ttt","bbb")
  b.check_out(20141215)
  #puts b.title()
  #puts b.inspect
  #puts b.to_s

  m = Member.new("ug","lug")
  m.check_out(b)
  m.check_out(b2)
  #m.give_back(b2)
  puts m.get_books()
  m.send_overdue_notice(" book is overdue")
=end
