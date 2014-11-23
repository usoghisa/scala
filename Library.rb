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
    return "id: #{@id}, title #{@title}, by Author #{@author}"
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
    @@currentMember=nil ###
  end  
  def getMember()
    return @@members
  end 
  def addMember(name, obj)
    @@members[name] = obj
  end
  def libIsOpen()
    (@@isLibOpen == false) ? (raise Exception.new(" \n The library is not open")) : return  
  end
  def custIsServe()
    (@@currentMember == nil) ? (raise Exception.new(" \n No member is currently been served")) : return 
  end
# current member book out and over   
def find_overdue_books() 
  libIsOpen()
  custIsServe()
  #puts"@@ currentMember.name book #{@@currentMember.bookBorrowed()[0].title}"
  bookOut=[[],[]]
  bookOut = loopBookArray(@@currentMember)
        if bookOut[1].size > 0
          @@currentMember.name
          print "#{@@currentMember.name} has overdue \n"
            bookOut[1].each do |i|  
              puts "#{i}  " 
            end
            return
        else 
          print "#{@@currentMember.name} has no overdue \n"
          return
        end       
end
def check_in(book_numbers)################# TODO remouve from @@books add book id returned
  libIsOpen() 
  custIsServe()
  for i in (0..@@currentMember.bookBorrowed().length-1)
    if(@@currentMember.bookBorrowed()[i].id() == book_numbers )
        @@currentMember.bookBorrowed()[i] = nil
        @@currentMember.bookBorrowed().delete(nil)
        return "@@currentMember.name #{@@currentMember.name} has return book id #{book_numbers} bookBorrowed()ARRAY #{@@currentMember.bookBorrowed()}"
    else
      raise Exception.new(" \n The member does have book id #{book_numbers}")
    end 
  end  
end
## Finds those Books whose title or author (or both) contains this string. case insensitive *KKK and kkk*
def search(string)
  #http://ruby-doc.org/core-2.1.5/String.html
  a = "cruel world"
  a = a.split
  print a
  # puts a.scan(/\w+/) 
  print a[1].scan(/.../)    
  
  s = string
  puts s[0, 4]  # => abcdef

  #puts s[-4,4]  
  puts s[s.length - 4,s.length]  
  
# http://docs.ruby-lang.org/en/trunk/Regexp.html
  
# If case is irrelevant, then a case-insensitive regular expression is a good solution:
  u="bcd"
return 'aBcDe' =~ /#{u}/i  # evaluates as true which is 1
  
  
  
  
  
  
  
  
 # my_string = string
 # if my_string.include? "cde"
 #    puts "String includes 'cde'"
 # end
end  
  def serve(name_of_member) 
    libIsOpen()
    if (@@currentMember != nil)  
      puts "sorry #{@@currentMember.name} but now i serve #{name_of_member}"
      @@currentMember = nil
    end  
    if (@@currentMember == nil)# puts getMember()
      if(isMember(name_of_member) == true)
        @@currentMember = getMember()[name_of_member.to_sym]
        #puts "@@currentMember.name is #{@@currentMember.name}"  
        return "Now serving #{@@currentMember.name} "
      else
        return "Sorry #{name_of_member} you must be a member to be served "
      end
    end
  end
  
  def isMember(name_of_member) #u= "k" puts "FFF2____ #{u == :k.to_s}"    puts  name_of_member
    found = false
    getMember().each_pair do |key,obj|
      if (key == name_of_member.to_sym)
        found = true
      end
    end
    return found
  end 
        
  def issue_card(name_of_member)
    libIsOpen()
    if (isMember(name_of_member) == false)
      addMember(name_of_member.to_sym, Member.new(name_of_member,"bbkLib"))
      return "\n Welcome #{name_of_member} to bbk"
    else
      return "Sorry this #{name_of_member} already exist"
    end
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
 
def loopBookArray(member)
      # [0] noOver [1] Over
      bookOut=[[],[]]   
      for i in 0 ... member.get_books.size############ < @@calendar
        if  ((member.get_books.size > 0)&&
        (member.get_books[i].get_due_date() >= @@calendar.get_date() ))
          # bookOut[1].push(member.get_books[i].title())
          bookOut[1].push(member.get_books[i])
        end
      end
      return bookOut
end
  
=begin
  listing the names of members who have overdue books, and for each such member, the
  books that are overdue. Or, the string "No books are overdue.”.
=end
  def find_all_overdue_books()
    libIsOpen() 
    puts "__3"#puts @@books[1]
    bookOut=[[],[]]
    name=""
    getMember().each_pair do |key,obj|
      if obj.get_books.size == 0
        puts key
        puts " No book are overdue "
      end
      ##....loopBookArray(member)
      bookOut = loopBookArray(obj)
      if bookOut[1].size > 0
        name= key
        print "#{name} has overdue \n"
        bookOut[1].each do |i|
          puts "#{i} , "
        end 
      end     
    end
     
   # print "#{n} has overdue \n"
   # t[1].each do |i|
   #   print "#{i} , "
   # end
     
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
begin
l=Library.new();
puts " The Library Is open #{l.open()}"
##l.open()




puts "ooo"
puts "getBookList() #{l.getBookList()}"
l.getBookList()[1].check_out(20141215)
# add member to lib
l.addMember(:ugo, Member.new("ugo","bbkLib"))
l.addMember(:pep, Member.new("pep","bbkLib"))
#l.addMember(:nino, Member.new("nino","bbkLib"))  


=begin 
=end
### Borrow Book
l.getMember()[:ugo].check_out(l.getBookList()[0])
l.getMember()[:ugo].check_out(l.getBookList()[1])
l.getBookList()[0].check_out(20141215) 
l.getBookList()[1].check_out(20141215) 
 
# puts l.getMember()[:ugo].inspect
puts l.getMember()[:ugo].bookBorrowed[0].getId()
puts l.getMember()[:ugo].bookBorrowed[0].get_due_date
puts l.getMember()[:ugo].bookBorrowed[1].getId()


l.find_all_overdue_books()
# puts l.getMember() 

  puts "call issue_card gino   #{l.issue_card('gino')}"
  puts "call issue_card 2   #{l.issue_card('gino')}"
  puts "call serve('gino')   #{l.serve('gino')}"
  puts "call find_overdue_books()"
  puts "#{l.find_overdue_books()}"
  
  puts "call serve('ugo')   #{l.serve('ugo')}"
  #puts "serve('kkk')   #{l.serve('kkk')}" 
  puts "call find_overdue_books()"
  puts "#{l.find_overdue_books()}"
  puts "l.check_in(1)  #{l.check_in(1)} "  
  puts "l.check_in(22)  #{l.check_in(2)} "   
 puts l.search("qwerty  xcvbnm")
rescue Exception => e
  puts e.message
end


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
