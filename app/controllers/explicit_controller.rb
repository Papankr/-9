# frozen_string_literal: true

class ExplicitController < ApplicationController
  def in; end

  def ajax
    string = params[:string]
    function_result = res_array
    if function_result[:key]
      respond_to do |format|
        format.json { render json: { key: true, maxlen: function_result[:maxlen], arrlist: function_result[:arrlist] } }
      end
    else
      respond_to do |format|
        format.json { render json: { key: false, error: function_result[:error] } }
      end
    end
  end

  private

  def res_array
    @str = '' unless @str = params[:string]
    kr5 = ->(x) { Math.sqrt(x).to_i**2 == x }
    @str = @str.split << '7'
    @str = @str.map(&:to_i)
    flag = false
    fa = []
    cra = []
    @str.each do |cr|
      if flag && kr5.call(cr) then cra << cr
      elsif !flag && kr5.call(cr) then fa << cra; flag = true; cra = []; cra << cr
      elsif flag && !(kr5.call cr) then fa << cra; flag = false; cra = [] end
    end
    @result = fa.reject(&:empty?)
    @maxlen = fa != [] ? fa.max_by(&:size).size : 0
    @result.empty? ? { key: false, error: 'Not found our array' } :
        { key: true, maxlen: @maxlen, arrlist: @result }
  end
end
