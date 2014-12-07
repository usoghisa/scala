require 'test/unit'
require 'Library.rb'

class LibraryTest < Test::Unit::TestCase 
  def setup
    @l=Library.new()
  end  
  def test_exception_on_open
    @l.open()  
    expectT=true
    assert_equal(expectT, @l.getIsLibOpen() ,msg="esp__________3")
    begin
      # Call the method that should throw an exception
      @l.open()
    rescue Exception => e # or you can test for specific exceptions
      expect1="The library is already open"
      assert_equal(expect1, e.message)
      puts "The open library exception work OK" # The exception happened, so the test passes
      return
    end     
    puts "test_exceptions fail"  
  end
  
  def test_exception_on_close
    @l.open()
    @l.close()
    expectT = false
    assert_equal(expectT, @l.getIsLibOpen() ,msg="esp__________4")
    expectT2 = nil
    assert_equal(expectT2, @l.getCurrentMember() ,msg="esp__________5")
    begin
      # Call the method that should throw an exception
      @l.open()
      expectT2 = "Good night"
      assert_equal(expectT2, @l.close() , msg="esp__________6")
      @l.close()
    rescue Exception => e # or you can test for specific exceptions
      expect1="The library is not open."
      assert_equal(expect1, e.message)
      puts "The close library exception work OK" # The exception happened, so the test passes
      return
    end
  end
#_____________ this method print What do we have to ??????????  
  def test_exception_on_find_overdue_books() 
    begin
     @l.libIsOpen() 
    rescue Exception => e # or you can test for specific exceptions
      expect1="The library is not open"
      assert_equal(expect1, e.message)
      puts "The libIsOpen() work OK" # The exception happened, so the test passes
    end
    begin
     @l.custIsServe()
    rescue Exception => e # or you can test for specific exceptions
      expect1="No member is currently been served"
      assert_equal(expect1, e.message)
      puts "The custIsServe() OK" # The exception happened, so the test passes
    end 
    @l.readFile()# make books list
    @l.open()
    @l.addMember(:ugo, Member.new("ugo","bbkLib"))
    @l.serve('ugo')
    due =(@l.calendar().get_date())-(7*24*60*60)# set date to be over due
    puts "CALL @l.getBookList()[0].check_out(due)#{@l.getBookList()[0].check_out(due)}"
    puts "CALL @l.getCurrentMember().check_out(@l.getBookList()[0])#{@l.getCurrentMember().check_out(@l.getBookList()[0])}"
    # puts "UUUU  #{@l.getBookList()[0].id()} "
    expectT = 1 
    assert_equal(expectT, @l.getBookList()[0].id() ,msg="esp__________A2")   
    @l.getBookList().delete_at(0) 
    overDueArray = @l.loopBookArray(@l.getCurrentMember())
    #puts "UUUU  #{@l.getBookList()[0].title()} "
    expectT = Array
    assert_equal(expectT, @l.loopBookArray(@l.getCurrentMember()).class ,msg="esp__________A")
    expectT = "ttt1" 
    assert_equal(expectT, overDueArray[1][0].title() ,msg="esp__________A2")       
  end
 end########### end LibraryTest
