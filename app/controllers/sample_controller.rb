class SampleController < ApplicationController
  
  skip_before_filter :verify_authenticity_token ,:only=>[:index]
  def index
    @title ="this is Index Page."
    @datas = Sample.all
    
    if request.post? then
      @str = params['text1']
     else 
      time = Time.now
     @str = time.to_s       
     end
  end
end
