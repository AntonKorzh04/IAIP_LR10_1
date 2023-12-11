require 'json'

class LuckyNumbersController < ApplicationController
    def input
    end

   def view
      @result = []
      0.upto(params[:numbers_count].to_i) do |i|
          number = ('0' * (6 - i.to_s.length)) + i.to_s
          @result.append(number) if (number[0..2].each_char.map(&:to_i).reduce(:+) == number[3..5].each_char.map(&:to_i).reduce(:+))
      end

      respond_to do |format|
        format.html
        format.json { render json: generate_json(@result) }
        format.xml { render xml: generate_xml(@result) }
      end
   end

   private

   # формирование json из результирующего массива чисел
   def generate_json(result)
    result_hash = {}
        result.each_with_index do |number, index|
        result_hash[index.to_s] = number.to_s
      end
      result_hash.to_json
   end

   # формирование xml документа с помощью nokogiri
   def generate_xml(result)
    xml_builder = Nokogiri::XML::Builder.new do |xml|
      xml.numbers('numbers_count' => params[:numbers_count], 'response_type' => params[:response_type]) do
          result.each_with_index do |number, index|
          xml.number(number, id: index)
        end
      end
    end

    xml_response = xml_builder.to_xml

    File.write('app/controllers/xml/xml_code.xml', xml_response)  # сохранить последний xml ответ
    xml_response
   end

end
