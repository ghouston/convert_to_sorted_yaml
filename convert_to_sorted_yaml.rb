require 'json'
require 'yaml'
require 'debug'

class ConvertToSortedYaml
    attr_accessor :filename
    def initialize(filename)
        @filename = filename
        @unhandled = [] # Keep track of types that didn't need spec
    end

    def convert
        puts "Converting #{@filename} to #{"#{filename}.yml"}"
        source = File.read(@filename)
        target = deep_convert_to_json(source)
        sorted = deep_sort(target)
        File.open("#{filename}.yml", 'w') { |file| file.write(sorted.to_yaml) }
    end

    private

    def deep_convert_to_json(source)
        if source.is_a? String
            begin
                if source =~ /^[\s\n]*[\{\[]/
                    result = JSON.parse(source)
                else
                    return source
                end
            rescue
                # failed to parse JSON, try to fix it
                # note, cant fix earlier since it might be nested json strings and the gsub would break it
                begin
                    # puts "Failed to parse JSON! String: #{source[0..15]}"
                    source.gsub!(/\/\/.*/,'') # Remove comments
                    source.gsub!(/,[\s\n]*}/,'}') # fix trailing commas
                    result = JSON.parse(source)
                rescue
                    return source
                end
            end
            return deep_convert_to_json(result)
        end

        if source.is_a? Hash
            result = {}
            source.each do |key,value|
                result[key] = deep_convert_to_json(value)
            end
            return result
        end

        if source.is_a? Array
            result = []
            source.each_with_index do |value, index|
                result << deep_convert_to_json(value)
            end
            return result
        end

        @unhandled << source.class
        return source
    end

    def deep_sort(source)
        if source.is_a? Hash
            result = {}
            source.each do |key,value|
                result[key] = deep_sort(value)
            end
            return result.sort.to_h
        end

        if source.is_a? Array
            result = []
            source.each do |value|
                if value.is_a?(Enumerable)
                    result << deep_sort(value)
                else
                    result << value
                end
            end

            result.sort! do |a,b|
                if a.is_a?(Enumerable) && b.is_a?(Enumerable)
                    a.to_a <=> b.to_a || 0 # to keep it simple, if the array compare fails, return 0
                else
                    a <=> b || 0 # to keep it simple, if the compare fails, return 0
                end
            end
            return result
        end

        @unhandled << source.class
        return source
    end
end

if __FILE__ == $PROGRAM_NAME
    files = Dir.glob('*.code-profile') + Dir.glob('*.json')
    files.each do |filename|
        ConvertToSortedYaml.new(filename).convert
    end
end
