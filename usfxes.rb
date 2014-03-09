#!/usr/bin/env ruby 

# Kind of hacky, but it seems to work.

require 'usfx'
require 'mixlib/cli'
require 'json'
require 'patron'
require 'elasticsearch'

class USFXtoES < USFX::Document
  include Mixlib::CLI
  option :parse_file,
    :short        => '-f FILE',
    :long         => '-file FILE',
    :default      => 'eng-web_usfx.xml',
    :description  => 'The USFX document to parse.'

  def elastic
    @esclient = Elasticsearch::Client.new log: true
  end

  def verse(data)
    # do something with verse data, which looks like:
    # {
    #   book_num: 1,
    #   book_id: 'GEN',
    #   book: 'Genesis',
    #   chapter: 1,
    #   verse: 1,
    #   text: 'In the beginning, God created the heavens and the earth.'
    # }
    verse = data.to_json
    id = "#{data[:book_id]} #{data[:chapter]}:#{data[:verse]}"
    @esclient.index index: 'web', type: data[:book_id], id: id, body: verse
    puts "Stored #{id}"
  end
end

usfx = USFXtoES.new
usfx.elastic
parser = USFX::Parser.new(usfx)
parser.parse(File.open(usfx.config[:parse_file]))
